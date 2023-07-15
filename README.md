<p align="center">
  <a href="" rel="noopener">
 <img width=400px height=200px src="https://camo.githubusercontent.com/37e7c20ae129b396a6985785199d24659eab4d758b7d639d83f9706b32992982/68747470733a2f2f6769746c61622e636f6d2f73616c74737461636b2f6f70656e2f73616c742d6272616e64696e672d67756964652f2d2f7261772f6d61737465722f6c6f676f732f53616c7450726f6a6563745f616c746c6f676f5f7465616c2e706e673f696e6c696e653d74727565" alt="Project Logo"></a>
</p>

<h3 align="center">SaltStack Project</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()

## Table of Contents

<div align="left">

- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)
- [Deploy](#deploy)

## About <a name = "about"></a>

SaltStack is a Python-based open-source configuration management software and remote execution engine. Supporting the "infrastructure-as-code" approach to deployment and cloud management, it competes primarily with Puppet, Chef, and Ansible.

## Getting Started <a name = "getting_started"></a>

You simply have to clone this repository to start to use it. It comes with a set of pre-configured states and pillars that you can use to configure your infrastructure. Salt can be used to configure a single machine or thousands of machines. It can be used to manage your infrastructure, deploy applications, and automate your daily tasks. Salt is a powerful and flexible tool, but it can be difficult to learn.

This project is part of the [Terraform](https://github.com/biaandersson/gloud-tf-automation) automation project. The Terraform project is used to deploy the infrastructure, setup the Salt Master, and install the Salt Minions. It uses the states, formulas and pillars in this repository to configure the infrastructure. So it's a part of a bigger project, but it can be used as a standalone project as well.

### Prerequisites

Remember to change the `salt.yml` in the .github/workflows directory to match the `main` branch. Or alternatively, you can create a new branch and change the `salt.yml` file to match the new branch.

```yaml
name: Deploy Salt Master

on:
  push:
    branches:
      - main # or whatever branch you want to use
  pull_request:
    branches:
      - main # or whatever branch you want to use
```

What things you need to install the software and how to install them.

```bash
git clone git@github.com:biaandersson/saltstack.git
cd saltstack
```

## Usage <a name = "usage"></a>

The default state and pillar that comes with this repository are simply for testing purposes. You can use them as a template to create your own states and pillars.

### States

```yaml
{%- set namespace = salt.pillar.get('apps:service:namespace') %}

{%- if namespace %}
set_namespace_grain:
  grains.present:
    - name: namespace
    - value: {{ namespace }}
    - force: True
{%- endif %}
```

This state will set the namespace grain if it is defined in the pillar. The namespace grain is used to define the namespace of the service. It is used to create the service user and group, and to create the service directory.

### Pillars

```yaml
apps:
  service:
    description: This is simple a dummy app
    type: Java Spring Boot Archtype
    namespace: testservice
    name: dummy-app
    version: 1.0.0
```

This allows you to match the namespace grain in the `top.sls` state file.

```yaml
# will match all minions in the 'foo' namespace
"namespace:foo":
  - foo_formula
  - bar_formula
  - foo_state
  - bar_state
```

You can simply run the following on the master to check the namespace grain.

```bash
root@test-saltmaster01:~/.ssh#
salt -G namespace:testservice pillar.items
test-web02:
    ----------
    apps:
        ----------
        service:
            ----------
            namespace:
                testservice
```

or alternatively

```bash
salt '*' grains.get namespace

test-web02:
    testservice
```

## Deploy <a name = "deploy"></a>

This repository is configured to use GitHub Actions to deploy the Salt Master. You can use the following workflow to deploy the Salt Master. You can also use the `salt.yml` file as a template to create your own workflow. Once you commit and push your changes to the `main` branch, GitHub Actions will deploy the Salt Master, and update the minions.

## Summary

This repository is a template for creating your own states and pillars. It is a good starting point for creating your own configuration management repository. I might add some `Formulas` and other states and pillars in the future.

Formulas are a collection of Salt states that are designed to be reusable. They are a great way to organize your Salt states and make them more portable and shareable. You can think of them as a way to package up your Salt states into a single unit that can be easily shared and reused. In simple terms, think of them as `React components` for Salt states.
