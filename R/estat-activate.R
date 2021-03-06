estat_activate_impl <- function(x, id, new_name) {
  stopifnot(id %in% x$id)

  if (!is.null(new_name)) {
    vctrs::vec_slice(x$new_name, x$id == id) <- new_name
  }
  attr(x, "active_id") <- id
  x
}

#' Determine which \code{estat} object key to edit.
#'
#' @param x A \code{estat} object.
#' @param pattern Pattern to look for.
#' @param new_name New column name.
#'
#' @return The \code{estat} object which the selected key is active.
#'
#' @examples
#' estat_activate_tab(estat_census_2020)
#' estat_activate_cat(estat_census_2020, 1)
#' estat_activate_area(estat_census_2020)
#' estat_activate_time(estat_census_2020)
#' @export
estat_activate <- function(x, pattern,
                           new_name = NULL) {
  id <- vctrs::vec_slice(x$id, stringr::str_detect(x$name, pattern))
  stopifnot(rlang::is_scalar_character(id))

  estat_activate_impl(x, id, new_name)
}

#' @rdname estat_activate
#' @export
estat_activate_tab <- function(x,
                               new_name = NULL) {
  estat_activate_impl(x, "tab", new_name)
}

#' @rdname estat_activate
#' @export
estat_activate_time <- function(x,
                                new_name = NULL) {
  estat_activate_impl(x, "time", new_name)
}

#' @rdname estat_activate
#' @export
estat_activate_area <- function(x,
                                new_name = NULL) {
  estat_activate_impl(x, "area", new_name)
}

#' @rdname estat_activate
#'
#' @param n A category number.
#'
#' @export
estat_activate_cat <- function(x, n,
                               new_name = NULL) {
  n <- stringr::str_pad(n, 2,
                        pad = "0")
  cat_n <- stringr::str_c("cat", n)

  estat_activate_impl(x, cat_n, new_name)
}
