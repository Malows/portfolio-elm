const path = require('path')
const webpack = require('webpack')
const merge = require('webpack-merge')


// const OptimizeCSSAssetsPlugin = require('optimize-css-assets-webpack-plugin')
// const ImageminPlugin = require('imagemin-webpack-plugin').default
const elmMinify = require('elm-minify')
const CopyWebpackPlugin = require('copy-webpack-plugin')
const HTMLWebpackPlugin = require('html-webpack-plugin')
const CleanWebpackPlugin = require('clean-webpack-plugin')
// to extract the css as a separate file
const MiniCssExtractPlugin = require('mini-css-extract-plugin')

const MODE =
    process.env.npm_lifecycle_event === 'prod' ? 'production' : 'development'

const publicPath = process.env.PUBLIC_PATH || '/'

const withDebug = !process.env['npm_config_nodebug']

console.log('\x1b[36m%s\x1b[0m', `** elm-webpack-starter: mode '${MODE}', withDebug: ${withDebug}\n`)

var common = {
    mode: MODE,
    entry: './src/index.js',
    output: {
        path: path.join(__dirname, 'dist'),
        publicPath,
        // FIXME webpack -p automatically adds hash when building for production
        // filename: MODE == 'production' ? '[name]-[hash].js' : 'index.js'
        filename: 'app.js'
    },
    plugins: [
        new HTMLWebpackPlugin({
            // Use this template to get basic responsive meta tags
            template: 'src/index.html',
            // inject details of output file at end of body
            inject: 'body'
        }),
        new CopyWebpackPlugin([{
            from: path.join(__dirname, 'node_modules/@fortawesome/fontawesome-free/webfonts'),
            to: 'fonts'
        }])
    ],
    resolve: {
        modules: [path.join(__dirname, 'src'), 'node_modules'],
        extensions: ['.js', '.elm', '.scss', '.png']
    },
    module: {
        rules: [
            {
                test: /\.js$/,
                exclude: /node_modules/,
                use: {
                    loader: 'babel-loader'
                }
            },
            {
                test: /\.scss$/,
                exclude: [/elm-stuff/, /node_modules/],
                // see https://github.com/webpack-contrib/css-loader#url
                loaders: ['style-loader', 'css-loader?url=false', 'sass-loader']
            },
            {
                test: /\.css$/,
                exclude: [/elm-stuff/, /node_modules/],
                loaders: ['style-loader', 'css-loader?url=false']
            },
            {
                test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: 'url-loader',
                options: {
                    limit: 10000,
                    mimetype: 'application/font-woff'
                }
            },
            {
                test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: 'file-loader'
            },
            {
                test: /\.(jpe?g|png|gif|svg)$/i,
                exclude: [/elm-stuff/, /node_modules/],
                loader: 'file-loader'
            }
        ]
    }
}

if (MODE === 'development') {
    module.exports = merge(common, {
        plugins: [
            // Suggested for hot-loading
            new webpack.NamedModulesPlugin(),
            // Prevents compilation errors causing the hot loader to lose state
            new webpack.NoEmitOnErrorsPlugin()
        ],
        module: {
            rules: [
                {
                    test: /\.elm$/,
                    exclude: [/elm-stuff/, /node_modules/],
                    use: [
                        { loader: 'elm-hot-webpack-loader' },
                        {
                            loader: 'elm-webpack-loader',
                            options: {
                                // add Elm's debug overlay to output
                                debug: withDebug,
                                //
                                forceWatch: true
                            }
                        }
                    ]
                }
            ]
        },
        devServer: {
            inline: true,
            stats: 'errors-only',
            contentBase: path.join(__dirname, 'src'),
            historyApiFallback: true,
            // feel free to delete this section if you don't need anything like this
            before(app) {
                // on port 3000
                app.get('/test', function(req, res) {
                    res.json({ result: 'OK' })
                })
            }
        }
    })
}

if (MODE === 'production') {
    module.exports = merge(common, {
        optimization: {
            splitChunks: {
                chunks: 'all'
            }
        },
        plugins: [
            // Minify elm code
            new elmMinify.WebpackPlugin(),
            // Delete everything from /dist directory and report to user
            new CleanWebpackPlugin(['dist'], {
                root: __dirname,
                exclude: [],
                verbose: true,
                dry: false
            }),
            // Copy static assets
            new CopyWebpackPlugin([{ from: 'src/img', to: 'img' }]),
            new MiniCssExtractPlugin({
                // Options similar to the same options in webpackOptions.output
                // both options are optional
                filename: '[name]-[hash].css'
            })
        ],
        module: {
            rules: [
                {
                    test: /\.elm$/,
                    exclude: [/elm-stuff/, /node_modules/],
                    use: {
                        loader: 'elm-webpack-loader',
                        options: {
                            optimize: true
                        }
                    }
                },
                {
                    test: /\.css$/,
                    exclude: [/elm-stuff/, /node_modules/],
                    loaders: [
                        MiniCssExtractPlugin.loader,
                        'css-loader?url=false'
                    ]
                },
                {
                    test: /\.scss$/,
                    exclude: [/elm-stuff/, /node_modules/],
                    loaders: [
                        MiniCssExtractPlugin.loader,
                        'css-loader?url=false',
                        'sass-loader'
                    ]
                }
            ]
        }
    })
}


// module.exports = {
//     entry: './src/index.js',

//     output: {
//         path: path.resolve(__dirname, 'dist'),
//         filename: 'index.js'
//     },

//     optimization: {
//         minimizer: [
//             new OptimizeCSSAssetsPlugin({})
//         ]
//     },

//     module: {
//         rules: [{
//             test: /\.html$/,
//             exclude: /node_modules/,
//             loader: 'file-loader?name=[name].[ext]'
//         }, {
//             test: /\.elm$/,
//             exclude: [/elm-stuff/, /node_modules/],
//             loader: 'elm-webpack-loader',
//             options: {
//                 debug: true
//             }
//         }, {
//             test: /\.s(a|c)ss$/,
//             use: [
//                 devMode ? 'style-loader' : MiniCssExtractPlugin.loader,
//                 'css-loader',
//                 'sass-loader'
//             ]
//         }, {
//             test: /\.woff2?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
//             use: 'url-loader?limit=10000',
//         }, {
//             test: /\.(ttf|eot|svg)(\?[\s\S]+)?$/,
//             use: 'file-loader',
//         }]
//     },

//     plugins: [
//         new CopyWebpackPlugin([
//             { from: 'src/img', to: 'img' }
//         ]),
//         new ImageminPlugin({
//             test: /\.(jpe?g|png|gif|svg)$/i
//         })
//     //     new MiniCssExtractPlugin({
//     //         filename: 'style.css',
//     //         chunkFilename: '[id].css'
//     //     })
//     ],

//     devServer: {
//         inline: true,
//         stats: 'errors-only'
//     }
// }
