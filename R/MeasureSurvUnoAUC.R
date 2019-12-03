#' @template surv_measure
#' @templateVar title Uno's AUC
#' @templateVar alias mlr_measures_surv.unoAUC
#' @templateVar inherit `MeasureSurvAUC`/[MeasureSurv]
#' @templateVar fullname MeasureSurvUnoAUC
#' @templateVar shortname surv.unoAUC
#' @templateVar pars integrated = TRUE, times
#' @templateVar int_par TRUE
#' @templateVar times_par TRUE
#'
#' @description
#' Calls [survAUC::AUC.uno()].
#'
#' Assumes random censoring.
#'
#' @template measure_survAUC
#'
#' @references
#' Uno, H., T. Cai, L. Tian, and L. J. Wei (2007).\cr
#' Evaluating prediction rules for t-year survivors with censored regression models.\cr
#' Journal of the American Statistical Association 102, 527–537.
#'
#' @family AUC survival measures
#' @export
MeasureSurvUnoAUC = R6Class("MeasureSurvUnoAUC",
  inherit = MeasureSurvAUC,
  public = list(
    initialize = function(integrated = TRUE, times) {
      super$initialize(integrated = integrated,
                       times = times,
                       id = "surv.unoAUC",
                       properties = c("requires_task", "requires_train_set"))
    },

    score_internal = function(prediction, task, train_set, ...) {
      super$score_internal(prediction = prediction,
                           task = task,
                           train_set = train_set,
                           FUN = survAUC::AUC.uno,
                           ...)
    }
  )
)