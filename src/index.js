import('./scss/style.scss')
import('./scss/font-awesome.scss')
import('./Main.elm')
  .then(({ Elm }) => {
    Elm.Main.init({ node: document.getElementById('root') })
  })


