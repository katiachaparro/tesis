// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import FlashController from "./flash_controller"
application.register("flash", FlashController)

import FlatpickrController from "./flatpickr_controller"
application.register("flatpickr", FlatpickrController)

import RemoteModalController from "./remote_modal_controller"
application.register("remote-modal", RemoteModalController)

import Static__NestedFormController from "./static/nested_form_controller"
application.register("nested-form", Static__NestedFormController)

import Ts__SelectController from "./ts/select_controller"
application.register("ts--select", Ts__SelectController)

import VisibilityController from "./visibility_controller"
application.register("visibility", VisibilityController)

import MapController from "./map_controller"
application.register("map", MapController)
