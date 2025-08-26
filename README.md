# prestashop-helm

This is a mirror of the GitLab repository containing the Helm chart that was developed during my [Wimma Capstone](https://wimma-capstone.jamk.fi/) internship. Its aim is to deploy PrestaShop on MicroK8s in a reproducible manner. It subsequently became one of the components of my Bachelor's thesis.

## Status

Operational but would benefit from some further development

## Documentation

Documentation can be found here: [Deploy custom PrestaShop Helm chart (internal repos)](https://wimma-capstone.pages.labranet.jamk.fi/support-material/3.%20OPS/Reference%20Product%20-%20Prestashop/Setup%20guides/Helm/helm-prestashop-deployment-internal-repos/)

## Further Development

* Security:
    * Add password generation logic. Currently, database password `dbPasswd` and admin dashboard password `adminPasswd` are declared manually in `prestashop/values.yaml`. This approach allows users to update passwords manually if needed, as shown in the attached documentation. However, a better approach would be to generate random passwords using [Helm random functions](https://helm.sh/docs/chart_template_guide/function_list/#randalphanum-randalpha-randnumeric-and-randascii) and store them as [secrets](https://kubernetes.io/docs/concepts/configuration/secret/), which can then be retrieved after deployment with the command that can be provided in the `prestashop/templates/NOTES.txt`. This approach is used in Bitnami PrestaShop Helm chart: [see](https://artifacthub.io/packages/helm/bitnami/prestashop)
    * Add pod security context: [see](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)

* Configurations:
    * Helpers (`_helpers.tpl`) require testing and updates 
    * Create a dedicated service account for the MySQL workload. Then, in `templates/mysql-stateful-or-deployment.yaml` line 39, update the `serviceAccountName` from `prestashop` to `mysql` and test functionality
    * Service account for the PrestaShop workload should also be reviewed and updated if needed
    * Use a custom namespace: [see](https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/)
    * Review the autoscaling configuration or remove it if not needed (`prestashop/templates/hpa.yaml`)
    * Fix the HTTP ingress naming logic, which is currently confusing - `ingress.enabled: false` enables HTTP ingress.
    * Implement probes: [see](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/)
