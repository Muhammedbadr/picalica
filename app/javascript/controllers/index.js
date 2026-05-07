import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

eagerLoadControllersFrom("controllers", application)

import CategorySelectController from "controllers/category_select_controller"
application.register("category-select", CategorySelectController)

import MultiSelectController from "controllers/multi_select_controller"
application.register("multi-select", MultiSelectController)

// Skip the select controller due to missing tom-select dependency
// import SelectController from "controllers/select_controller"
// application.register("select", SelectController)