#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title JiraLink
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }
# @raycast.packageName JiraLink

# Documentation:
# @raycast.description JiraLink
# @raycast.author maxmanders
# @raycast.authorURL https://raycast.com/maxmanders

issue_id="$(echo -n ${1} | tr '[:lower:]' '[:upper:]')"
echo -n "[${issue_id}](https://<INSERT ATLASSIAN URL>/browse/${issue_id})" | pbcopy
