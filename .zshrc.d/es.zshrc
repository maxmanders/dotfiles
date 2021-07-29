#!/usr/bin/env bash

es_get_endpoint() {
  local domain_name
  local endpoint

  domain_name="${1}"
  endpoint="$(aws es describe-elasticsearch-domain --domain-name ${domain_name} --query 'DomainStatus.Endpoints.vpc' | tr -d '"')"
  if [ "${endpoint}" = "null" ]; then
    endpoint="$(aws es describe-elasticsearch-domain --domain-name ${domain_name} --query 'DomainStatus.Endpoint' | tr -d '"')"
  fi

  echo -n "${endpoint}"
}

es_get_disk_usage() {
  local domain_name
  domain_name="${1}"
  curl --silent --request GET "$(es_get_endpoint ${domain_name})/_cat/allocation?v&pretty"
}

es_get_index_usage() {
  local domain_name
  domain_name="${1}"
  curl --silent --request GET "$(es_get_endpoint ${domain_name})/_cat/indices?v&pretty"
}

es_get_index_usage() {
  local domain_name
  domain_name="${1}"
  curl --silent --request GET "$(es_get_endpoint ${domain_name})/_cat/indices?v&pretty"
}

es_get_cluster_health() {
  local domain_name
  domain_name="${1}"
  curl --silent --request GET "$(es_get_endpoint ${domain_name})/_cluster/health?pretty"
}

es_get_cluster_state() {
  local domain_name
  domain_name="${1}"
  curl --silent --request GET "$(es_get_endpoint ${domain_name})/_cluster/state?pretty"
}

es_list_indices() {
  local domain_name
  domain_name="${1}"
  curl --silent --request GET "$(es_get_endpoint ${domain_name})/_cat/indices?v&pretty"
}

es_get_index() {
  local domain_name
  local index
  domain_name="${1}"
  index="${2}"
  curl --silent --request GET "$(es_get_endpoint ${domain_name})/${index}?pretty"
}
