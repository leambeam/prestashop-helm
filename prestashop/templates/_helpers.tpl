{{/*
Expand the name of the chart.
*/}}
{{- define "prestashop.name" -}}
{{- default .Chart.Name .Values.prestashop.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prestashop.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.prestashop.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.prestashop.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "prestashop.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "prestashop.labels" -}}
helm.sh/chart: {{ include "prestashop.chart" . }}
{{ include "prestashop.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "prestashop.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prestashop.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "prestashop.serviceAccountName" -}}
{{- if .Values.prestashop.serviceAccount.create }}
{{- default (include "prestashop.fullname" .) .Values.prestashop.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.prestashop.serviceAccount.name }}
{{- end }}
{{- end }}

{{- define "mysql.fullname" -}}
{{ .Release.Name }}-mysql
{{- end -}}

{{- define "mysql.labels" -}}
app.kubernetes.io/name: mysql
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "mysql.selectorLabels" -}}
app.kubernetes.io/name: mysql
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}





