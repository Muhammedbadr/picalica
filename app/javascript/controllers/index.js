import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

eagerLoadControllersFrom("controllers", application)

import CategorySelectController from "controllers/category_select_controller"
application.register("category-select", CategorySelectController)

import StarRatingController from "controllers/star_rating_controller"
import MultiSelectController from "controllers/multi_select_controller"
import CheckboxGroupController from "controllers/checkbox_group_controller"
application.register("star-rating", StarRatingController)
application.register("multi-select", MultiSelectController)
application.register("checkbox-group", CheckboxGroupController)

// Skip the select controller due to missing tom-select dependency
// import SelectController from "controllers/select_controller"
// application.register("select", SelectController)