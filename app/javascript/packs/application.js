// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import $ from 'jquery';

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
require("packs/posts")
require("packs/comments")
require("packs/readmorecomment")
require("packs/search")
require("packs/sidenav")
require("packs/jquery.easy-autocomplete")

import 'bootstrap';

import "@fortawesome/fontawesome-free/css/all"
import 'src/application.scss'

document.addEventListener("turbolinks:load", () => {
	$('[data-toggle="tooltip"]').tooltip()
	$('[data-toggle="popover"]').popover()
})






