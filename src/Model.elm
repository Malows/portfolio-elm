module Model exposing (Model, init)

import Types exposing (Knowledge, Service)


type alias Model =
    { socialContact : List ( String, String )
    , selectedKnowledge : Maybe Knowledge
    , knowledges : List Knowledge
    , services : List Service
    , welcomeMessage : String
    }


init : Model
init =
    let
        socialItems =
            [ ( "twitter", "https://twitter.com/wroughtbywind" )
            , ( "github", "https://github.com/Malows" )
            , ( "gitlab", "https://gitlab.com/Malows" )
            , ( "linkedin", "https://www.linkedin.com/in/juan-manuel-cruz-0a8116b5/" )
            ]

        knowledges =
            [ Knowledge
                "JavaScript"
                """A great experience in JavaScript, working professionally with Node developing apps with real-time captabilities, high concurrency, or a great user's parallel connections amount.
                Also working in front-end development and a great experience in Vue framework and their ecosystem.
                I worked with React, preact, others frameworks and libraries and vanilla JS. Promoting the use of libraries when they really add some value to the develop over the overhead.
                Experience in profiling, testing and debugging.
                A functional-style programming evangelist. """
                "img/skills/javascript.svg"
            , Knowledge
                "Python"
                """A wide experience working with Python.
                Developing CLI tools, automating processes for development and deployment stages.
                And a quiet good experience in web development using Django.
                I used Python for educational purpose, teaching how-to program, or mentoring the growth of yunglings and people who are growing into their professional career."""
                "img/skills/python.svg"
            , Knowledge
                "PHP"
                """A confident skill developing backend applications from a frameworkless flavor.
                Passing through simplest frameworks like CodeIgniter until complex and high-level frameworks like Laravel.
                Used to develop management software and handcrafted solutions."""
                "img/skills/php.svg"
            , Knowledge
                "Elm"
                """I started to use Elm for my personal projects. With a really good development experience and exceptionals results.
                Starting to port some olds projects to this wonderful language"""
                "img/skills/elm.svg"
            , Knowledge
                "Rust"
                """As same as Elm, I started to port some cli tools and small autimations projects to Rust.
                To bring robustness and efficience.
                Also I discovered in Rust a fantastic language for microservices and backend development"""
                "img/skills/rust.svg"
            , Knowledge
                "C/C++"
                """I started to develop in C++.
                Also during my degree it was my main language.
                Developing OpenGL apps, working with distributed structures and learning the bases of algorithms."""
                "img/skills/cpp.svg"
            ]

        services =
            [ Service
                "Development"
                "lorem ipsum"
                "terminal"
            , Service
                "Automation & Deployment"
                "lorem ipsum"
                "cogs"
            , Service
                "Secure implementation"
                "lorem ipsum"
                "lock"
            ]

        welcome =
            "Nice to see you around"
    in
    Model socialItems Nothing knowledges services welcome
