#' @template surv_measure
#' @templateVar title O'Quigley, Xu, and Stare's R2
#' @templateVar inherit [MeasureSurv]
#' @templateVar fullname MeasureSurvOQuigleyR2
#' @templateVar shortname surv.oquigleyR2
#' @description
#' Calls [survAUC::OXS()].
#'
#' Assumes Cox PH model specification.
#'
#' @template measure_survAUC
#'
#' @references
#' O'Quigley, J., R. Xu, and J. Stare (2005).\cr
#' Explained randomness in proportional hazards models.\cr
#' Statistics in Medicine 24, 479–489.
#'
#' @family R2 survival measures
#' @export
MeasureSurvOQuigleyR2 = R6Class("MeasureSurvOQuigleyR2",
  inherit = MeasureSurv,
  public = list(
    initialize = function() {
      super$initialize(
        id = "surv.oquigleyR2",
        range = 0:1,
        minimize = FALSE,
        packages = "survAUC",
        predict_type = "lp",
        properties = c("requires_task", "requires_train_set")
      )
    },

    score_internal = function(prediction, task, train_set, ...) {
      surv_train = task$truth(train_set)

      survAUC::OXS(surv_train, prediction$lp, rep(0, length(prediction$lp)))
    }
  )
)