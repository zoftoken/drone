# Drone CI plugin for ZofToken integration

## Introduction

When any form of Continuous Integration is used for making changes to production environments (a classic example would be deploying a master branch to a live service) it's important to ensure that this is not done by error or without proper authorization.

The usual way to handle this is at the repository level, by only having specific users allowed to commit or merge changes to critical branches. While this is certainly fine in general, there might be situations where this type of control is hard to implement (for example, business owners rarely have the tools/knowledge to be part of this cycle) or a more stringent approach is required by security policies, compliance processes or audit requirements.

This plugin for the popular Drone CI solution takes a different approach and allows for the integration of [ZofToken](https://www.zoftoken.com/) right into a build/deploy pipeline. Notice that this can be used in addition to branch protection (for additional security or specific requirements as mentioned earlier) or even when branch protection is unavailable or undesirable.

The [ZofToken as a Service (ZaaS)](https://zaas.zoftoken.com/) cloud implementation of ZofToken provides a free-forever tier of up to 20 tokens which can be used with this plugin.

## Usage

The plugin has 4 parameters:

- Instance: (OPTIONAL) The API endpoint for ZofToken operations - it defaults to the ZaaS provided endpoint so any token created on ZaaS will work without including this parameter.
- Id: The token id.
- Service: The service the token belongs to.
- Authkey: The authkey needed to access the id/service combination (in the case of ZaaS, you can use the "Basic Auth" shown on the "My Services" page). It is recommended to use a Drone secret for this parameter to prevent exposing it in the repository.

The plugin will exit with failure (typically aborting the pipeline) if the parameters are invalid or the selected token is not in the open position.

A typical usage within a pipeline will look like this (inside the "steps" of the pipeline):

```
- name: validate_zoftoken
  image: zoftoken/drone
  settings:
    Id: joe_business_owner
    Service: yourcompany_compliance_tokens
    Authkey:
      from_secret: compliance_tokens_authkey
  when:
    branch:
    - master    
```

In this case a subscription called "yourcompany" was created in ZaaS, with a service called "compliance_tokens" and one token was created and enrolled for "joe_business_owner" who potentially has no idea what continuous integration or a branch even is, but now has an app in his phone that prevents any deployments of the service he owns without him actually providing an active, documented (in the CI logs) and auditable authorization.

## Roadmap

The current version of the plugin is a very simple shell script (in part to show the simplicity of integrating ZofToken into any service) and while it's easy to force the requirement to be several tokens (for example, the IT manager and the business owner) just by using the plugin multiples times, a future version will include more complex logic to allow one of several approvers, group tokens to make decisions, etc.