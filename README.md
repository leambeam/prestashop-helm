# presta-shop-helm-x


## Status

In progress

## TL;DR

1. Get the chart:

```
git clone https://gitlab.labranet.jamk.fi/presta-shop-development-release-x/presta-shop-deployment/presta-shop-helm-x.git
cd presta-shop-helm-x/
```

2. Enable `metallb`

```
echo "<your-floating-ip>-<your-floating-ip>" | sudo microk8s enable metallb
```

3. Enable `ingress`

```
microk8s enable ingress
```

4. Install the chart: 

**Note: it is required to set `psDomain` to your floating ip**

```
microk8s helm install presta-helm prestashop \
  --set prestashop.env.psDomain="<your-floating-ip>" 
```

5. Wait for a few minutes and visit the PrestaShop at your `floating-ip`

## Variables

These are default variables that are used for PrestaShop auto install and mysql database setup. 

```yaml
    dbName: "prestashop"
    dbPasswd: "adminPrEsTa123" 
    psInstallAuto: "1" # Set to true thus will perform an auto install.
    psDomain: "relaamo.fi"
    psCountry: "FI"
    psLanguage: "en"
    adminMail: "testuser@mail.com"
    adminPasswd: "ReAlPaSsWoRd759***"
    psFolderAdmin: "admin228"
```

You can modify all of the variables on install by using the '--set' flag and respective variable name as well as its new value.

```bash
microk8s helm install presta-helm prestashop \
  --set prestashop.env.psDomain="<your-floating-ip>" \
  --set prestashop.env.dbPasswd="<new-password>" \
  --set prestashop.env.adminMail="<new-email>" \
  --set prestashop.env.adminPasswd="<new-password>" \
  --set prestashop.env.psFolderAdmin="<new-folder>" \
  --set prestashop.env.psLanguage="<new-language>" \
  --set prestashop.env.psCountry="<new-country>" \
  --set prestashop.env.dbName="<new-db-name>" 
```

You can modify only one if you wish so:

```bash
microk8s helm install presta-helm prestashop \
  --set prestashop.env.dbPasswd="<new-password>" 
```


**Be aware that if you set auto install to '0' PrestaShop will not be installed automatically!**