---
layout: post
title: "{{ replace .TranslationBaseName "-" " " | title }}"
slug: {{ replaceRE "^[0-9]*-[0-9]*-[0-9]*-" "$1" .Name }}
date: {{ .Date }}
lastmod: {{ .Date }}
comments: true
categories:
  - ""
tags:
  - ""
---
