#' @include MeasureSurvIntegrated.R
MeasureSurvAUC = R6Class("MeasureSurvAUC",
  inherit = MeasureSurvIntegrated,
  public = list(
    initialize = function(integrated = TRUE, times, id, properties) {
      if(class(self)[[1]] == "MeasureSurvAUC")
        stop("This is an abstract class that should not be constructed directly.")

      super$initialize(
        integrated = integrated,
        times = times,
        id = id,
        range = 0:1,
        minimize = FALSE,
        packages = "survAUC",
        predict_type = "lp",
        properties = properties
      )
    },

    score_internal = function(prediction, learner, task, train_set, FUN, ...) {
      args = list()
      if("requires_train_set" %in% self$properties)
        args$Surv.rsp = task$truth(train_set)
      if ("requires_learner" %in% self$properties)
        args$lp = learner$model$linear.predictors

      args$times = self$times
      if(length(args$times) == 0)
        args$times = sort(unique(prediction$truth[, 1]))

      if("Surv.rsp.new" %in% names(formals(FUN)))
        args$Surv.rsp.new = prediction$truth

      auc = invoke(FUN, lpnew = prediction$lp, .args = args)

      if(self$integrated & !grepl("TNR|TPR", self$id)) {
        return(auc$iauc)
      } else {
        return(auc)
      }
    }
  )
)