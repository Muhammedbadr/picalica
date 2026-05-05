import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

eagerLoadControllersFrom("controllers", application)

import CategorySelectController from "./category_select_controller"
application.register("category-select", CategorySelectController)