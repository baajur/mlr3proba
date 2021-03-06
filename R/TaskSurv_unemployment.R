#' @title Unemployment Duration Survival Task
#' @name mlr_tasks_unemployment
#' @description
#' A survival task for the `UnempDur` data set.
#'
#' @format [R6::R6Class] inheriting from [TaskSurv].
#'
#' @section Construction:
#' ```
#' mlr3::mlr_tasks$get("unemployment")
#' mlr3::tsk("unemployment")
#' ```
#' @template seealso_task
#'
#' @details
#' A survival task for the "UnempDur" data set in package \CRANpkg{Ecdat}.
#' Contains the following columns of the original data set:
#' "spell" (time), "censor1" (status), "age", "ui", "logwage", and "tenure".
NULL
load_unemployment = function() {
  path = file.path(system.file("extdata", package = "mlr3proba"), "unemployment.rds")
  b = as_data_backend(readRDS(path))
  b$hash = "_mlr3_survival_unemployment_"
  TaskSurv$new("unemployment", b, time = "spell", event = "censor1")
}
