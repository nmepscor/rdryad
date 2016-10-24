#' Search the Dryad Solr endpoint.
#'
#' @export
#'
#' @param ... Solr parameters passed on to the respective \pkg{solrium} package
#' function.
#' @param proxy List of arguments for a proxy connection, including one or
#' more of: url, port, username, password, and auth. See
#' \code{\link[httr]{use_proxy}} for help, which is used to construct the
#' proxy connection.
#' @param errors (character) One of simple or complete. Simple gives http
#' code and error message on an error, while complete gives both http code and
#' error message, and stack trace, if available.
#' @param verbose (logical) Whether to print help messages or not. E.g., if
#' \code{TRUE}, we print the URL on each request to a Solr server for your
#' reference. Default: \code{TRUE}
#' @param callopts Further args passed on to \code{\link[httr]{GET}}
#'
#' @details See the \code{solrium} package documentation for available
#' parameters. For each of \code{d_solr_search}, \code{d_solr_facet},
#' \code{d_solr_stats}, and \code{d_solr_mlt}, \code{d_solr_group}, and
#' \code{d_solr_highlight} see the equivalently named function in \pkg{solrium}.
#'
#' @examples \dontrun{
#' # Basic search
#' d_solr_search(q="Galliard")
#'
#' # Basic search, restricting to certain fields
#' d_solr_search(q="Galliard", fl='handle,dc.title_sort')
#'
#' # Search all text for a string, but limits results to two specified fields:
#' d_solr_search(q="dwc.ScientificName:drosophila", fl='handle,dc.title_sort')
#'
#' # Dryad data based on an article DOI:
#' d_solr_search(q="dc.relation.isreferencedby:10.1038/nature04863",
#'    fl="dc.identifier,dc.title_ac")
#'
#' # All terms in the dc.subject facet, along with their frequencies:
#' d_solr_facet(q="location:l2", facet.field="dc.subject_filter", facet.minCount=1,
#'    facet.limit=10)
#'
#' # Article DOIs associated with all data published in Dryad over the past 90 days:
#' d_solr_search(q="dc.date.available_dt:[NOW-90DAY/DAY TO NOW]",
#'    fl="dc.relation.isreferencedby", rows=10)
#'
#' # Data DOIs published in Dryad during January 2011, with results returned in JSON format:
#' query <- "location:l2 dc.date.available_dt:[2011-01-01T00:00:00Z TO 2011-01-31T23:59:59Z]"
#' d_solr_search(q=query, fl="dc.identifier", rows=10)
#'
#' # Highlight
#' d_solr_highlight(q="bird", hl.fl="dc.description")
#'
#' # More like this
#' d_solr_mlt(q="bird", mlt.count=10, mlt.fl='dc.title_sort', fl='handle,dc.title_sort')
#'
#' # Stats
#' d_solr_stats(q="*:*", stats.field="dc.date.accessioned.year")
#' }
d_solr_search <- function(..., verbose = TRUE, errors = "simple", proxy = NULL,
                          callopts = list()) {
  check_conn(verbose, errors, proxy)
  solrium::solr_search(..., callopts = callopts)
}

#' @export
#' @rdname d_solr_search
d_solr_facet <- function(..., verbose = TRUE, errors = "simple", proxy = NULL,
                         callopts = list()) {
  check_conn(verbose, errors, proxy)
  solrium::solr_facet(..., callopts = callopts)
}

#' @export
#' @rdname d_solr_search
d_solr_group <- function(..., verbose = TRUE, errors = "simple", proxy = NULL,
                         callopts = list()) {
  check_conn(verbose, errors, proxy)
  solrium::solr_group(..., callopts = callopts)
}

#' @export
#' @rdname d_solr_search
d_solr_highlight <- function(..., verbose = TRUE, errors = "simple", proxy = NULL,
                             callopts = list()) {
  check_conn(verbose, errors, proxy)
  solrium::solr_highlight(..., callopts = callopts)
}

#' @export
#' @rdname d_solr_search
d_solr_mlt <- function(..., verbose = TRUE, errors = "simple", proxy = NULL,
                       callopts = list()) {
  check_conn(verbose, errors, proxy)
  solrium::solr_mlt(..., callopts = callopts)
}

#' @export
#' @rdname d_solr_search
d_solr_stats <- function(..., verbose = TRUE, errors = "simple", proxy = NULL,
                         callopts = list()) {
  check_conn(verbose, errors, proxy)
  solrium::solr_stats(..., callopts = callopts)
}

dsolrbase <- function() "http://datadryad.org/solr/search/select"

check_conn <- function(verbose, errors, proxy) {
  solrium::solr_connect(dsolrbase(), proxy = proxy, errors = errors, verbose = verbose)
}
