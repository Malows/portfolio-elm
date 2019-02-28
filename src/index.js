// require('./index.html')
import('./scss/style.scss')
import('./Main.elm')
  .then(({ Elm }) => {
    // if (module.hot) {
    //     module.hot.dispose(() => {
    //         window.location.reload()
    //     })
    // }

    Elm.Main.init({ node: document.getElementById('root') })
  })


