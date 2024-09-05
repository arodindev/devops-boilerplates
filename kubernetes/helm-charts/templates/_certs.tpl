{{/*
Expand the name of the chart for the todo app.
*/}}
{{- define "todoapp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}



{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "todoapp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Generate certificates for todoapp
*/}}
{{- define "todoapp.gen-certs" -}}
{{- $altNames := list ( printf "%s.%s" (include "todoapp.name" .) .Values.namespace ) ( printf "%s.%s.svc" (include "todoapp.name" .) .Values.namespace ) -}}
{{- $ca := genCA "todoapp-ca" 365 -}}
{{- $cert := genSignedCert "todoapp.arodindev.com" nil $altNames 365 $ca -}}
tls.crt: {{ $cert.Cert | b64enc }}
tls.key: {{ $cert.Key | b64enc }}
{{- end -}}
