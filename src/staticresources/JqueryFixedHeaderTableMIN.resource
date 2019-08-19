



<!DOCTYPE html>
<html lang="en" class=" is-copy-enabled is-u2f-enabled">
  <head prefix="og: http://ogp.me/ns# fb: http://ogp.me/ns/fb# object: http://ogp.me/ns/object# article: http://ogp.me/ns/article# profile: http://ogp.me/ns/profile#">
    <meta charset='utf-8'>

    <link crossorigin="anonymous" href="https://assets-cdn.github.com/assets/frameworks-2ba71e22c2db6ac43901e1e30abf4ab38b45568bcb7ce203ba904a1b4c773a3c.css" integrity="sha256-K6ceIsLbasQ5AeHjCr9Ks4tFVovLfOIDupBKG0x3Ojw=" media="all" rel="stylesheet" />
    <link crossorigin="anonymous" href="https://assets-cdn.github.com/assets/github-6ea92208a310f289418159a4ed57aae089fbc83e376d5d3d8d6a07a2cf0e3887.css" integrity="sha256-bqkiCKMQ8olBgVmk7Veq4In7yD43bV09jWoHos8OOIc=" media="all" rel="stylesheet" />
    
    
    <link crossorigin="anonymous" href="https://assets-cdn.github.com/assets/site-2d5d1699983d8dd7c384c67dfc183fbace8e3a24866e8822069d599f68e71fb2.css" integrity="sha256-LV0WmZg9jdfDhMZ9/Bg/us6OOiSGbogiBp1Zn2jnH7I=" media="all" rel="stylesheet" />
    

    <link as="script" href="https://assets-cdn.github.com/assets/frameworks-302f480057178545736799a8434a8d19d238532dc06f4beacae560cf5a7f4376.js" rel="preload" />
    
    <link as="script" href="https://assets-cdn.github.com/assets/github-f83ae2f0d483dddc8f1894b3cc2709ff1db48511ddc8d054ed639c52c80d54c9.js" rel="preload" />

    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta http-equiv="Content-Language" content="en">
    <meta name="viewport" content="width=1020">
    
    
    <title>Fixed-Header-Table/jquery.fixedheadertable.min.js at master · markmalek/Fixed-Header-Table · GitHub</title>
    <link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="GitHub">
    <link rel="fluid-icon" href="https://github.com/fluidicon.png" title="GitHub">
    <link rel="apple-touch-icon" href="/apple-touch-icon.png">
    <link rel="apple-touch-icon" sizes="57x57" href="/apple-touch-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="/apple-touch-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="/apple-touch-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="/apple-touch-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="/apple-touch-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="/apple-touch-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="/apple-touch-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="/apple-touch-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon-180x180.png">
    <meta property="fb:app_id" content="1401488693436528">

      <meta content="https://avatars2.githubusercontent.com/u/669713?v=3&amp;s=400" name="twitter:image:src" /><meta content="@github" name="twitter:site" /><meta content="summary" name="twitter:card" /><meta content="markmalek/Fixed-Header-Table" name="twitter:title" /><meta content="Fixed-Header-Table - jQuery plugin for tables with fixed headers " name="twitter:description" />
      <meta content="https://avatars2.githubusercontent.com/u/669713?v=3&amp;s=400" property="og:image" /><meta content="GitHub" property="og:site_name" /><meta content="object" property="og:type" /><meta content="markmalek/Fixed-Header-Table" property="og:title" /><meta content="https://github.com/markmalek/Fixed-Header-Table" property="og:url" /><meta content="Fixed-Header-Table - jQuery plugin for tables with fixed headers " property="og:description" />
      <meta name="browser-stats-url" content="https://api.github.com/_private/browser/stats">
    <meta name="browser-errors-url" content="https://api.github.com/_private/browser/errors">
    <link rel="assets" href="https://assets-cdn.github.com/">
    
    <meta name="pjax-timeout" content="1000">
    

    <meta name="msapplication-TileImage" content="/windows-tile.png">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="selected-link" value="repo_source" data-pjax-transient>

    <meta name="google-site-verification" content="KT5gs8h0wvaagLKAVWq8bbeNwnZZK1r1XQysX3xurLU">
<meta name="google-site-verification" content="ZzhVyEFwb7w3e0-uOTltm8Jsck2F5StVihD0exw2fsA">
    <meta name="google-analytics" content="UA-3769691-2">

<meta content="collector.githubapp.com" name="octolytics-host" /><meta content="github" name="octolytics-app-id" /><meta content="6738AD01:386C:2AA45046:571F2174" name="octolytics-dimension-request_id" />
<meta content="/&lt;user-name&gt;/&lt;repo-name&gt;/blob/show" data-pjax-transient="true" name="analytics-location" />



  <meta class="js-ga-set" name="dimension1" content="Logged Out">



        <meta name="hostname" content="github.com">
    <meta name="user-login" content="">

        <meta name="expected-hostname" content="github.com">
      <meta name="js-proxy-site-detection-payload" content="MDNjMGVkODAxZTk4MzgwYzNkYWY5NTA1YTM0YzYzOWNjOTkwN2I5MjZkN2VjNDkwNDVmODM5MGE2YzA0NjBjYnx7InJlbW90ZV9hZGRyZXNzIjoiMTAzLjU2LjE3My4xIiwicmVxdWVzdF9pZCI6IjY3MzhBRDAxOjM4NkM6MkFBNDUwNDY6NTcxRjIxNzQiLCJ0aW1lc3RhbXAiOjE0NjE2NTc5NzN9">


      <link rel="mask-icon" href="https://assets-cdn.github.com/pinned-octocat.svg" color="#4078c0">
      <link rel="icon" type="image/x-icon" href="https://assets-cdn.github.com/favicon.ico">

    <meta content="ac094262bcef44408c51264cf852f50eb0993988" name="form-nonce" />

    <meta http-equiv="x-pjax-version" content="360b6ed4239d15aabdb66b7df5eacbec">
    

      
  <meta name="description" content="Fixed-Header-Table - jQuery plugin for tables with fixed headers ">
  <meta name="go-import" content="github.com/markmalek/Fixed-Header-Table git https://github.com/markmalek/Fixed-Header-Table.git">

  <meta content="669713" name="octolytics-dimension-user_id" /><meta content="markmalek" name="octolytics-dimension-user_login" /><meta content="1567277" name="octolytics-dimension-repository_id" /><meta content="markmalek/Fixed-Header-Table" name="octolytics-dimension-repository_nwo" /><meta content="true" name="octolytics-dimension-repository_public" /><meta content="false" name="octolytics-dimension-repository_is_fork" /><meta content="1567277" name="octolytics-dimension-repository_network_root_id" /><meta content="markmalek/Fixed-Header-Table" name="octolytics-dimension-repository_network_root_nwo" />
  <link href="https://github.com/markmalek/Fixed-Header-Table/commits/master.atom" rel="alternate" title="Recent Commits to Fixed-Header-Table:master" type="application/atom+xml">


      <link rel="canonical" href="https://github.com/markmalek/Fixed-Header-Table/blob/master/jquery.fixedheadertable.min.js" data-pjax-transient>
  </head>


  <body class="logged-out   env-production windows vis-public page-blob">
    <div id="js-pjax-loader-bar" class="pjax-loader-bar"></div>
    <a href="#start-of-content" tabindex="1" class="accessibility-aid js-skip-to-content">Skip to content</a>

    
    
    



          <header class="site-header js-details-container" role="banner">
  <div class="container-responsive">
    <a class="header-logo-invertocat" href="https://github.com/" aria-label="Homepage" data-ga-click="(Logged out) Header, go to homepage, icon:logo-wordmark">
      <svg aria-hidden="true" class="octicon octicon-mark-github" height="32" version="1.1" viewBox="0 0 16 16" width="32"><path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59 0.4 0.07 0.55-0.17 0.55-0.38 0-0.19-0.01-0.82-0.01-1.49-2.01 0.37-2.53-0.49-2.69-0.94-0.09-0.23-0.48-0.94-0.82-1.13-0.28-0.15-0.68-0.52-0.01-0.53 0.63-0.01 1.08 0.58 1.23 0.82 0.72 1.21 1.87 0.87 2.33 0.66 0.07-0.52 0.28-0.87 0.51-1.07-1.78-0.2-3.64-0.89-3.64-3.95 0-0.87 0.31-1.59 0.82-2.15-0.08-0.2-0.36-1.02 0.08-2.12 0 0 0.67-0.21 2.2 0.82 0.64-0.18 1.32-0.27 2-0.27 0.68 0 1.36 0.09 2 0.27 1.53-1.04 2.2-0.82 2.2-0.82 0.44 1.1 0.16 1.92 0.08 2.12 0.51 0.56 0.82 1.27 0.82 2.15 0 3.07-1.87 3.75-3.65 3.95 0.29 0.25 0.54 0.73 0.54 1.48 0 1.07-0.01 1.93-0.01 2.2 0 0.21 0.15 0.46 0.55 0.38C13.71 14.53 16 11.53 16 8 16 3.58 12.42 0 8 0z"></path></svg>
    </a>

    <button class="btn-link right site-header-toggle js-details-target" type="button" aria-label="Toggle navigation">
      <svg aria-hidden="true" class="octicon octicon-three-bars" height="24" version="1.1" viewBox="0 0 12 16" width="18"><path d="M11.41 9H0.59c-0.59 0-0.59-0.41-0.59-1s0-1 0.59-1h10.81c0.59 0 0.59 0.41 0.59 1s0 1-0.59 1z m0-4H0.59c-0.59 0-0.59-0.41-0.59-1s0-1 0.59-1h10.81c0.59 0 0.59 0.41 0.59 1s0 1-0.59 1zM0.59 11h10.81c0.59 0 0.59 0.41 0.59 1s0 1-0.59 1H0.59c-0.59 0-0.59-0.41-0.59-1s0-1 0.59-1z"></path></svg>
    </button>

    <div class="site-header-menu">
      <nav class="site-header-nav site-header-nav-main">
        <a href="/personal" class="js-selected-navigation-item nav-item nav-item-personal" data-ga-click="Header, click, Nav menu - item:personal" data-selected-links="/personal /personal">
          Personal
</a>        <a href="/open-source" class="js-selected-navigation-item nav-item nav-item-opensource" data-ga-click="Header, click, Nav menu - item:opensource" data-selected-links="/open-source /open-source">
          Open source
</a>        <a href="/business" class="js-selected-navigation-item nav-item nav-item-business" data-ga-click="Header, click, Nav menu - item:business" data-selected-links="/business /business/features /business/customers /business">
          Business
</a>        <a href="/explore" class="js-selected-navigation-item nav-item nav-item-explore" data-ga-click="Header, click, Nav menu - item:explore" data-selected-links="/explore /trending /trending/developers /integrations /integrations/feature/code /integrations/feature/collaborate /integrations/feature/ship /explore">
          Explore
</a>      </nav>

      <div class="site-header-actions">
            <a class="btn btn-primary site-header-actions-btn" href="/join?source=header-repo" data-ga-click="(Logged out) Header, clicked Sign up, text:sign-up">Sign up</a>
          <a class="btn site-header-actions-btn mr-2" href="/login?return_to=%2Fmarkmalek%2FFixed-Header-Table%2Fblob%2Fmaster%2Fjquery.fixedheadertable.min.js" data-ga-click="(Logged out) Header, clicked Sign in, text:sign-in">Sign in</a>
      </div>

        <nav class="site-header-nav site-header-nav-secondary">
          <a class="nav-item" href="/pricing">Pricing</a>
          <a class="nav-item" href="/blog">Blog</a>
          <a class="nav-item" href="https://help.github.com">Support</a>
          <a class="nav-item header-search-link" href="https://github.com/search">Search GitHub</a>
              <div class="header-search scoped-search site-scoped-search js-site-search" role="search">
  <!-- </textarea> --><!-- '"` --><form accept-charset="UTF-8" action="/markmalek/Fixed-Header-Table/search" class="js-site-search-form" data-scoped-search-url="/markmalek/Fixed-Header-Table/search" data-unscoped-search-url="/search" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
    <label class="form-control header-search-wrapper js-chromeless-input-container">
      <div class="header-search-scope">This repository</div>
      <input type="text"
        class="form-control header-search-input js-site-search-focus js-site-search-field is-clearable"
        data-hotkey="s"
        name="q"
        placeholder="Search"
        aria-label="Search this repository"
        data-unscoped-placeholder="Search GitHub"
        data-scoped-placeholder="Search"
        tabindex="1"
        autocapitalize="off">
    </label>
</form></div>

        </nav>
    </div>
  </div>
</header>



    <div id="start-of-content" class="accessibility-aid"></div>

      <div id="js-flash-container">
</div>


    <div role="main" class="main-content">
        <div itemscope itemtype="http://schema.org/SoftwareSourceCode">
    <div id="js-repo-pjax-container" data-pjax-container>
      
<div class="pagehead repohead instapaper_ignore readability-menu experiment-repo-nav">
  <div class="container repohead-details-container">

    

<ul class="pagehead-actions">

  <li>
      <a href="/login?return_to=%2Fmarkmalek%2FFixed-Header-Table"
    class="btn btn-sm btn-with-count tooltipped tooltipped-n"
    aria-label="You must be signed in to watch a repository" rel="nofollow">
    <svg aria-hidden="true" class="octicon octicon-eye" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path d="M8.06 2C3 2 0 8 0 8s3 6 8.06 6c4.94 0 7.94-6 7.94-6S13 2 8.06 2z m-0.06 10c-2.2 0-4-1.78-4-4 0-2.2 1.8-4 4-4 2.22 0 4 1.8 4 4 0 2.22-1.78 4-4 4z m2-4c0 1.11-0.89 2-2 2s-2-0.89-2-2 0.89-2 2-2 2 0.89 2 2z"></path></svg>
    Watch
  </a>
  <a class="social-count" href="/markmalek/Fixed-Header-Table/watchers">
    65
  </a>

  </li>

  <li>
      <a href="/login?return_to=%2Fmarkmalek%2FFixed-Header-Table"
    class="btn btn-sm btn-with-count tooltipped tooltipped-n"
    aria-label="You must be signed in to star a repository" rel="nofollow">
    <svg aria-hidden="true" class="octicon octicon-star" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path d="M14 6l-4.9-0.64L7 1 4.9 5.36 0 6l3.6 3.26L2.67 14l4.33-2.33 4.33 2.33L10.4 9.26 14 6z"></path></svg>
    Star
  </a>

    <a class="social-count js-social-count" href="/markmalek/Fixed-Header-Table/stargazers">
      665
    </a>

  </li>

  <li>
      <a href="/login?return_to=%2Fmarkmalek%2FFixed-Header-Table"
        class="btn btn-sm btn-with-count tooltipped tooltipped-n"
        aria-label="You must be signed in to fork a repository" rel="nofollow">
        <svg aria-hidden="true" class="octicon octicon-repo-forked" height="16" version="1.1" viewBox="0 0 10 16" width="10"><path d="M8 1c-1.11 0-2 0.89-2 2 0 0.73 0.41 1.38 1 1.72v1.28L5 8 3 6v-1.28c0.59-0.34 1-0.98 1-1.72 0-1.11-0.89-2-2-2S0 1.89 0 3c0 0.73 0.41 1.38 1 1.72v1.78l3 3v1.78c-0.59 0.34-1 0.98-1 1.72 0 1.11 0.89 2 2 2s2-0.89 2-2c0-0.73-0.41-1.38-1-1.72V9.5l3-3V4.72c0.59-0.34 1-0.98 1-1.72 0-1.11-0.89-2-2-2zM2 4.2c-0.66 0-1.2-0.55-1.2-1.2s0.55-1.2 1.2-1.2 1.2 0.55 1.2 1.2-0.55 1.2-1.2 1.2z m3 10c-0.66 0-1.2-0.55-1.2-1.2s0.55-1.2 1.2-1.2 1.2 0.55 1.2 1.2-0.55 1.2-1.2 1.2z m3-10c-0.66 0-1.2-0.55-1.2-1.2s0.55-1.2 1.2-1.2 1.2 0.55 1.2 1.2-0.55 1.2-1.2 1.2z"></path></svg>
        Fork
      </a>

    <a href="/markmalek/Fixed-Header-Table/network" class="social-count">
      429
    </a>
  </li>
</ul>

    <h1 class="entry-title public ">
  <svg aria-hidden="true" class="octicon octicon-repo" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path d="M4 9h-1v-1h1v1z m0-3h-1v1h1v-1z m0-2h-1v1h1v-1z m0-2h-1v1h1v-1z m8-1v12c0 0.55-0.45 1-1 1H6v2l-1.5-1.5-1.5 1.5V14H1c-0.55 0-1-0.45-1-1V1C0 0.45 0.45 0 1 0h10c0.55 0 1 0.45 1 1z m-1 10H1v2h2v-1h3v1h5V11z m0-10H2v9h9V1z"></path></svg>
  <span class="author" itemprop="author"><a href="/markmalek" class="url fn" rel="author">markmalek</a></span><!--
--><span class="path-divider">/</span><!--
--><strong itemprop="name"><a href="/markmalek/Fixed-Header-Table" data-pjax="#js-repo-pjax-container">Fixed-Header-Table</a></strong>

</h1>

  </div>
  <div class="container">
    
<nav class="reponav js-repo-nav js-sidenav-container-pjax"
     itemscope
     itemtype="http://schema.org/BreadcrumbList"
     role="navigation"
     data-pjax="#js-repo-pjax-container">

  <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
    <a href="/markmalek/Fixed-Header-Table" aria-selected="true" class="js-selected-navigation-item selected reponav-item" data-hotkey="g c" data-selected-links="repo_source repo_downloads repo_commits repo_releases repo_tags repo_branches /markmalek/Fixed-Header-Table" itemprop="url">
      <svg aria-hidden="true" class="octicon octicon-code" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path d="M9.5 3l-1.5 1.5 3.5 3.5L8 11.5l1.5 1.5 4.5-5L9.5 3zM4.5 3L0 8l4.5 5 1.5-1.5L2.5 8l3.5-3.5L4.5 3z"></path></svg>
      <span itemprop="name">Code</span>
      <meta itemprop="position" content="1">
</a>  </span>

    <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
      <a href="/markmalek/Fixed-Header-Table/issues" class="js-selected-navigation-item reponav-item" data-hotkey="g i" data-selected-links="repo_issues repo_labels repo_milestones /markmalek/Fixed-Header-Table/issues" itemprop="url">
        <svg aria-hidden="true" class="octicon octicon-issue-opened" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path d="M7 2.3c3.14 0 5.7 2.56 5.7 5.7S10.14 13.7 7 13.7 1.3 11.14 1.3 8s2.56-5.7 5.7-5.7m0-1.3C3.14 1 0 4.14 0 8s3.14 7 7 7 7-3.14 7-7S10.86 1 7 1z m1 3H6v5h2V4z m0 6H6v2h2V10z"></path></svg>
        <span itemprop="name">Issues</span>
        <span class="counter">91</span>
        <meta itemprop="position" content="2">
</a>    </span>

  <span itemscope itemtype="http://schema.org/ListItem" itemprop="itemListElement">
    <a href="/markmalek/Fixed-Header-Table/pulls" class="js-selected-navigation-item reponav-item" data-hotkey="g p" data-selected-links="repo_pulls /markmalek/Fixed-Header-Table/pulls" itemprop="url">
      <svg aria-hidden="true" class="octicon octicon-git-pull-request" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path d="M11 11.28c0-1.73 0-6.28 0-6.28-0.03-0.78-0.34-1.47-0.94-2.06s-1.28-0.91-2.06-0.94c0 0-1.02 0-1 0V0L4 3l3 3V4h1c0.27 0.02 0.48 0.11 0.69 0.31s0.3 0.42 0.31 0.69v6.28c-0.59 0.34-1 0.98-1 1.72 0 1.11 0.89 2 2 2s2-0.89 2-2c0-0.73-0.41-1.38-1-1.72z m-1 2.92c-0.66 0-1.2-0.55-1.2-1.2s0.55-1.2 1.2-1.2 1.2 0.55 1.2 1.2-0.55 1.2-1.2 1.2zM4 3c0-1.11-0.89-2-2-2S0 1.89 0 3c0 0.73 0.41 1.38 1 1.72 0 1.55 0 5.56 0 6.56-0.59 0.34-1 0.98-1 1.72 0 1.11 0.89 2 2 2s2-0.89 2-2c0-0.73-0.41-1.38-1-1.72V4.72c0.59-0.34 1-0.98 1-1.72z m-0.8 10c0 0.66-0.55 1.2-1.2 1.2s-1.2-0.55-1.2-1.2 0.55-1.2 1.2-1.2 1.2 0.55 1.2 1.2z m-1.2-8.8c-0.66 0-1.2-0.55-1.2-1.2s0.55-1.2 1.2-1.2 1.2 0.55 1.2 1.2-0.55 1.2-1.2 1.2z"></path></svg>
      <span itemprop="name">Pull requests</span>
      <span class="counter">17</span>
      <meta itemprop="position" content="3">
</a>  </span>

    <a href="/markmalek/Fixed-Header-Table/wiki" class="js-selected-navigation-item reponav-item" data-hotkey="g w" data-selected-links="repo_wiki /markmalek/Fixed-Header-Table/wiki">
      <svg aria-hidden="true" class="octicon octicon-book" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path d="M2 5h4v1H2v-1z m0 3h4v-1H2v1z m0 2h4v-1H2v1z m11-5H9v1h4v-1z m0 2H9v1h4v-1z m0 2H9v1h4v-1z m2-6v9c0 0.55-0.45 1-1 1H8.5l-1 1-1-1H1c-0.55 0-1-0.45-1-1V3c0-0.55 0.45-1 1-1h5.5l1 1 1-1h5.5c0.55 0 1 0.45 1 1z m-8 0.5l-0.5-0.5H1v9h6V3.5z m7-0.5H8.5l-0.5 0.5v8.5h6V3z"></path></svg>
      Wiki
</a>

  <a href="/markmalek/Fixed-Header-Table/pulse" class="js-selected-navigation-item reponav-item" data-selected-links="pulse /markmalek/Fixed-Header-Table/pulse">
    <svg aria-hidden="true" class="octicon octicon-pulse" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path d="M11.5 8L8.8 5.4 6.6 8.5 5.5 1.6 2.38 8H0V10h3.6L4.5 8.2l0.9 5.4L9 8.5l1.6 1.5H14V8H11.5z"></path></svg>
    Pulse
</a>
  <a href="/markmalek/Fixed-Header-Table/graphs" class="js-selected-navigation-item reponav-item" data-selected-links="repo_graphs repo_contributors /markmalek/Fixed-Header-Table/graphs">
    <svg aria-hidden="true" class="octicon octicon-graph" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path d="M16 14v1H0V0h1v14h15z m-11-1H3V8h2v5z m4 0H7V3h2v10z m4 0H11V6h2v7z"></path></svg>
    Graphs
</a>

</nav>

  </div>
</div>

<div class="container new-discussion-timeline experiment-repo-nav">
  <div class="repository-content">

    

<a href="/markmalek/Fixed-Header-Table/blob/77eb2dfb20e2fb5457f44d20780db921f3f62dab/jquery.fixedheadertable.min.js" class="hidden js-permalink-shortcut" data-hotkey="y">Permalink</a>

<!-- blob contrib key: blob_contributors:v21:7be2aac7f5406ae6de9d3df44edbe6a3 -->

<div class="file-navigation js-zeroclipboard-container">
  
<div class="select-menu branch-select-menu js-menu-container js-select-menu left">
  <button class="btn btn-sm select-menu-button js-menu-target css-truncate" data-hotkey="w"
    title="master"
    type="button" aria-label="Switch branches or tags" tabindex="0" aria-haspopup="true">
    <i>Branch:</i>
    <span class="js-select-button css-truncate-target">master</span>
  </button>

  <div class="select-menu-modal-holder js-menu-content js-navigation-container" data-pjax aria-hidden="true">

    <div class="select-menu-modal">
      <div class="select-menu-header">
        <svg aria-label="Close" class="octicon octicon-x js-menu-close" height="16" role="img" version="1.1" viewBox="0 0 12 16" width="12"><path d="M7.48 8l3.75 3.75-1.48 1.48-3.75-3.75-3.75 3.75-1.48-1.48 3.75-3.75L0.77 4.25l1.48-1.48 3.75 3.75 3.75-3.75 1.48 1.48-3.75 3.75z"></path></svg>
        <span class="select-menu-title">Switch branches/tags</span>
      </div>

      <div class="select-menu-filters">
        <div class="select-menu-text-filter">
          <input type="text" aria-label="Filter branches/tags" id="context-commitish-filter-field" class="form-control js-filterable-field js-navigation-enable" placeholder="Filter branches/tags">
        </div>
        <div class="select-menu-tabs">
          <ul>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="branches" data-filter-placeholder="Filter branches/tags" class="js-select-menu-tab" role="tab">Branches</a>
            </li>
            <li class="select-menu-tab">
              <a href="#" data-tab-filter="tags" data-filter-placeholder="Find a tag…" class="js-select-menu-tab" role="tab">Tags</a>
            </li>
          </ul>
        </div>
      </div>

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="branches" role="menu">

        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


            <a class="select-menu-item js-navigation-item js-navigation-open "
               href="/markmalek/Fixed-Header-Table/blob/gh-pages/jquery.fixedheadertable.min.js"
               data-name="gh-pages"
               data-skip-pjax="true"
               rel="nofollow">
              <svg aria-hidden="true" class="octicon octicon-check select-menu-item-icon" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path d="M12 5L4 13 0 9l1.5-1.5 2.5 2.5 6.5-6.5 1.5 1.5z"></path></svg>
              <span class="select-menu-item-text css-truncate-target js-select-menu-filter-text" title="gh-pages">
                gh-pages
              </span>
            </a>
            <a class="select-menu-item js-navigation-item js-navigation-open selected"
               href="/markmalek/Fixed-Header-Table/blob/master/jquery.fixedheadertable.min.js"
               data-name="master"
               data-skip-pjax="true"
               rel="nofollow">
              <svg aria-hidden="true" class="octicon octicon-check select-menu-item-icon" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path d="M12 5L4 13 0 9l1.5-1.5 2.5 2.5 6.5-6.5 1.5 1.5z"></path></svg>
              <span class="select-menu-item-text css-truncate-target js-select-menu-filter-text" title="master">
                master
              </span>
            </a>
        </div>

          <div class="select-menu-no-results">Nothing to show</div>
      </div>

      <div class="select-menu-list select-menu-tab-bucket js-select-menu-tab-bucket" data-tab-filter="tags">
        <div data-filterable-for="context-commitish-filter-field" data-filterable-type="substring">


        </div>

        <div class="select-menu-no-results">Nothing to show</div>
      </div>

    </div>
  </div>
</div>

  <div class="btn-group right">
    <a href="/markmalek/Fixed-Header-Table/find/master"
          class="js-pjax-capture-input btn btn-sm"
          data-pjax
          data-hotkey="t">
      Find file
    </a>
    <button aria-label="Copy file path to clipboard" class="js-zeroclipboard btn btn-sm zeroclipboard-button tooltipped tooltipped-s" data-copied-hint="Copied!" type="button">Copy path</button>
  </div>
  <div class="breadcrumb js-zeroclipboard-target">
    <span class="repo-root js-repo-root"><span class="js-path-segment"><a href="/markmalek/Fixed-Header-Table"><span>Fixed-Header-Table</span></a></span></span><span class="separator">/</span><strong class="final-path">jquery.fixedheadertable.min.js</strong>
  </div>
</div>


  <div class="commit-tease">
      <span class="right">
        <a class="commit-tease-sha" href="/markmalek/Fixed-Header-Table/commit/300eea76d0038dbe8d57c11e677152979b6eb0d4" data-pjax>
          300eea7
        </a>
        <time datetime="2014-02-27T10:50:27Z" is="relative-time">Feb 27, 2014</time>
      </span>
      <div>
        <img alt="" class="avatar" height="20" src="https://1.gravatar.com/avatar/a9f85e3b3efe43bee07d7bfb389c9cd5?d=https%3A%2F%2Fassets-cdn.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png&amp;r=x&amp;s=140" width="20" />
        <span class="user-mention">hiddes</span>
          <a href="/markmalek/Fixed-Header-Table/commit/300eea76d0038dbe8d57c11e677152979b6eb0d4" class="message" data-pjax="true" title="Copy inline styles from original table">Copy inline styles from original table</a>
      </div>

    <div class="commit-tease-contributors">
      <button type="button" class="btn-link muted-link contributors-toggle" data-facebox="#blob_contributors_box">
        <strong>1</strong>
         contributor
      </button>
      
    </div>

    <div id="blob_contributors_box" style="display:none">
      <h2 class="facebox-header" data-facebox-id="facebox-header">Users who have contributed to this file</h2>
      <ul class="facebox-user-list" data-facebox-id="facebox-description">
          <li class="facebox-user-list-item">
            <img alt="@markmalek" height="24" src="https://avatars2.githubusercontent.com/u/669713?v=3&amp;s=48" width="24" />
            <a href="/markmalek">markmalek</a>
          </li>
      </ul>
    </div>
  </div>

<div class="file">
  <div class="file-header">
  <div class="file-actions">

    <div class="btn-group">
      <a href="/markmalek/Fixed-Header-Table/raw/master/jquery.fixedheadertable.min.js" class="btn btn-sm " id="raw-url">Raw</a>
        <a href="/markmalek/Fixed-Header-Table/blame/master/jquery.fixedheadertable.min.js" class="btn btn-sm js-update-url-with-hash">Blame</a>
      <a href="/markmalek/Fixed-Header-Table/commits/master/jquery.fixedheadertable.min.js" class="btn btn-sm " rel="nofollow">History</a>
    </div>

        <a class="btn-octicon tooltipped tooltipped-nw"
           href="https://windows.github.com"
           aria-label="Open this file in GitHub Desktop"
           data-ga-click="Repository, open with desktop, type:windows">
            <svg aria-hidden="true" class="octicon octicon-device-desktop" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path d="M15 2H1c-0.55 0-1 0.45-1 1v9c0 0.55 0.45 1 1 1h5.34c-0.25 0.61-0.86 1.39-2.34 2h8c-1.48-0.61-2.09-1.39-2.34-2h5.34c0.55 0 1-0.45 1-1V3c0-0.55-0.45-1-1-1z m0 9H1V3h14v8z"></path></svg>
        </a>

        <button type="button" class="btn-octicon disabled tooltipped tooltipped-nw"
          aria-label="You must be signed in to make or propose changes">
          <svg aria-hidden="true" class="octicon octicon-pencil" height="16" version="1.1" viewBox="0 0 14 16" width="14"><path d="M0 12v3h3l8-8-3-3L0 12z m3 2H1V12h1v1h1v1z m10.3-9.3l-1.3 1.3-3-3 1.3-1.3c0.39-0.39 1.02-0.39 1.41 0l1.59 1.59c0.39 0.39 0.39 1.02 0 1.41z"></path></svg>
        </button>
        <button type="button" class="btn-octicon btn-octicon-danger disabled tooltipped tooltipped-nw"
          aria-label="You must be signed in to make or propose changes">
          <svg aria-hidden="true" class="octicon octicon-trashcan" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path d="M10 2H8c0-0.55-0.45-1-1-1H4c-0.55 0-1 0.45-1 1H1c-0.55 0-1 0.45-1 1v1c0 0.55 0.45 1 1 1v9c0 0.55 0.45 1 1 1h7c0.55 0 1-0.45 1-1V5c0.55 0 1-0.45 1-1v-1c0-0.55-0.45-1-1-1z m-1 12H2V5h1v8h1V5h1v8h1V5h1v8h1V5h1v9z m1-10H1v-1h9v1z"></path></svg>
        </button>
  </div>

  <div class="file-info">
      21 lines (19 sloc)
      <span class="file-info-divider"></span>
    10.4 KB
  </div>
</div>

  

  <div itemprop="text" class="blob-wrapper data type-javascript">
      <table class="highlight tab-size js-file-line-container" data-tab-size="8">
      <tr>
        <td id="L1" class="blob-num js-line-number" data-line-number="1"></td>
        <td id="LC1" class="blob-code blob-code-inner js-file-line"><span class="pl-c">/*!</span></td>
      </tr>
      <tr>
        <td id="L2" class="blob-num js-line-number" data-line-number="2"></td>
        <td id="LC2" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> * jquery.fixedHeaderTable. The jQuery fixedHeaderTable plugin</span></td>
      </tr>
      <tr>
        <td id="L3" class="blob-num js-line-number" data-line-number="3"></td>
        <td id="LC3" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> *</span></td>
      </tr>
      <tr>
        <td id="L4" class="blob-num js-line-number" data-line-number="4"></td>
        <td id="LC4" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> * Copyright (c) 2013 Mark Malek</span></td>
      </tr>
      <tr>
        <td id="L5" class="blob-num js-line-number" data-line-number="5"></td>
        <td id="LC5" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> * http://fixedheadertable.com</span></td>
      </tr>
      <tr>
        <td id="L6" class="blob-num js-line-number" data-line-number="6"></td>
        <td id="LC6" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> *</span></td>
      </tr>
      <tr>
        <td id="L7" class="blob-num js-line-number" data-line-number="7"></td>
        <td id="LC7" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> * Licensed under MIT</span></td>
      </tr>
      <tr>
        <td id="L8" class="blob-num js-line-number" data-line-number="8"></td>
        <td id="LC8" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> * http://www.opensource.org/licenses/mit-license.php</span></td>
      </tr>
      <tr>
        <td id="L9" class="blob-num js-line-number" data-line-number="9"></td>
        <td id="LC9" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> *</span></td>
      </tr>
      <tr>
        <td id="L10" class="blob-num js-line-number" data-line-number="10"></td>
        <td id="LC10" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> * http://docs.jquery.com/Plugins/Authoring</span></td>
      </tr>
      <tr>
        <td id="L11" class="blob-num js-line-number" data-line-number="11"></td>
        <td id="LC11" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> * jQuery authoring guidelines</span></td>
      </tr>
      <tr>
        <td id="L12" class="blob-num js-line-number" data-line-number="12"></td>
        <td id="LC12" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> *</span></td>
      </tr>
      <tr>
        <td id="L13" class="blob-num js-line-number" data-line-number="13"></td>
        <td id="LC13" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> * Launch  : October 2009</span></td>
      </tr>
      <tr>
        <td id="L14" class="blob-num js-line-number" data-line-number="14"></td>
        <td id="LC14" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> * Version : 1.3</span></td>
      </tr>
      <tr>
        <td id="L15" class="blob-num js-line-number" data-line-number="15"></td>
        <td id="LC15" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> * Released: May 9th, 2011</span></td>
      </tr>
      <tr>
        <td id="L16" class="blob-num js-line-number" data-line-number="16"></td>
        <td id="LC16" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> *</span></td>
      </tr>
      <tr>
        <td id="L17" class="blob-num js-line-number" data-line-number="17"></td>
        <td id="LC17" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> *</span></td>
      </tr>
      <tr>
        <td id="L18" class="blob-num js-line-number" data-line-number="18"></td>
        <td id="LC18" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> * all CSS sizing (width,height) is done in pixels (px)</span></td>
      </tr>
      <tr>
        <td id="L19" class="blob-num js-line-number" data-line-number="19"></td>
        <td id="LC19" class="blob-code blob-code-inner js-file-line"><span class="pl-c"> */(function(c){c.fn.fixedHeaderTable=function(m){var u={width:&quot;100%&quot;,height:&quot;100%&quot;,themeClass:&quot;fht-default&quot;,borderCollapse:!0,fixedColumns:0,fixedColumn:!1,sortable:!1,autoShow:!0,footer:!1,cloneHeadToFoot:!1,autoResize:!1,create:null},b={},n={init:function(a){b=c.extend({},u,a);return this.each(function(){var a=c(this);h._isTable(a)?(n.setup.apply(this,Array.prototype.slice.call(arguments,1)),c.isFunction(b.create)&amp;&amp;b.create.call(this)):c.error(&quot;Invalid table mark-up&quot;)})},setup:function(){var a=c(this), d=a.find(&quot;thead&quot;),e=a.find(&quot;tfoot&quot;),g=0,f,k,p;b.originalTable=c(this).clone();b.includePadding=h._isPaddingIncludedWithWidth();b.scrollbarOffset=h._getScrollbarWidth();b.themeClassName=b.themeClass;f=-1&lt;b.width.search(&quot;%&quot;)?a.parent().width()-b.scrollbarOffset:b.width-b.scrollbarOffset;a.css({width:f});a.closest(&quot;.fht-table-wrapper&quot;).length||(a.addClass(&quot;fht-table&quot;),a.wrap(&#39;&lt;div class=&quot;fht-table-wrapper&quot;&gt;&lt;/div&gt;&#39;));f=a.closest(&quot;.fht-table-wrapper&quot;);!0==b.fixedColumn&amp;&amp;0&gt;=b.fixedColumns&amp;&amp;(b.fixedColumns= 1);0&lt;b.fixedColumns&amp;&amp;0==f.find(&quot;.fht-fixed-column&quot;).length&amp;&amp;(a.wrap(&#39;&lt;div class=&quot;fht-fixed-body&quot;&gt;&lt;/div&gt;&#39;),c(&#39;&lt;div class=&quot;fht-fixed-column&quot;&gt;&lt;/div&gt;&#39;).prependTo(f),k=f.find(&quot;.fht-fixed-body&quot;));f.css({width:b.width,height:b.height}).addClass(b.themeClassName);a.hasClass(&quot;fht-table-init&quot;)||a.wrap(&#39;&lt;div class=&quot;fht-tbody&quot;&gt;&lt;/div&gt;&#39;);p=a.closest(&quot;.fht-tbody&quot;);var l=h._getTableProps(a);h._setupClone(p,l.tbody);a.hasClass(&quot;fht-table-init&quot;)?k=f.find(&quot;div.fht-thead&quot;):(k=0&lt;b.fixedColumns?c(&#39;&lt;div class=&quot;fht-thead&quot;&gt;&lt;table class=&quot;fht-table&quot;&gt;&lt;/table&gt;&lt;/div&gt;&#39;).prependTo(k): c(&#39;&lt;div class=&quot;fht-thead&quot;&gt;&lt;table class=&quot;fht-table&quot;&gt;&lt;/table&gt;&lt;/div&gt;&#39;).prependTo(f),k.find(&quot;table.fht-table&quot;).addClass(b.originalTable.attr(&quot;class&quot;)).attr(&quot;style&quot;,b.originalTable.attr(&quot;style&quot;)),d.clone().appendTo(k.find(&quot;table&quot;)));h._setupClone(k,l.thead);a.css({&quot;margin-top&quot;:-k.outerHeight(!0)});!0==b.footer&amp;&amp;(h._setupTableFooter(a,this,l),e.length||(e=f.find(&quot;div.fht-tfoot table&quot;)),g=e.outerHeight(!0));d=f.height()-d.outerHeight(!0)-g-l.border;p.css({height:d});a.addClass(&quot;fht-table-init&quot;);&quot;undefined&quot;!== typeof b.altClass&amp;&amp;n.altRows.apply(this);0&lt;b.fixedColumns&amp;&amp;h._setupFixedColumn(a,this,l);b.autoShow||f.hide();h._bindScroll(p,l);return this},resize:function(){return this},altRows:function(a){var d=c(this);a=&quot;undefined&quot;!==typeof a?a:b.altClass;d.closest(&quot;.fht-table-wrapper&quot;).find(&quot;tbody tr:odd:not(:hidden)&quot;).addClass(a)},show:function(a,d,b){var g=c(this),f=g.closest(&quot;.fht-table-wrapper&quot;);if(&quot;undefined&quot;!==typeof a&amp;&amp;&quot;number&quot;===typeof a)return f.show(a,function(){c.isFunction(d)&amp;&amp;d.call(this)}),this; if(&quot;undefined&quot;!==typeof a&amp;&amp;&quot;string&quot;===typeof a&amp;&amp;&quot;undefined&quot;!==typeof d&amp;&amp;&quot;number&quot;===typeof d)return f.show(a,d,function(){c.isFunction(b)&amp;&amp;b.call(this)}),this;g.closest(&quot;.fht-table-wrapper&quot;).show();c.isFunction(a)&amp;&amp;a.call(this);return this},hide:function(a,d,b){var g=c(this),f=g.closest(&quot;.fht-table-wrapper&quot;);if(&quot;undefined&quot;!==typeof a&amp;&amp;&quot;number&quot;===typeof a)return f.hide(a,function(){c.isFunction(b)&amp;&amp;b.call(this)}),this;if(&quot;undefined&quot;!==typeof a&amp;&amp;&quot;string&quot;===typeof a&amp;&amp;&quot;undefined&quot;!==typeof d&amp;&amp;&quot;number&quot;=== typeof d)return f.hide(a,d,function(){c.isFunction(b)&amp;&amp;b.call(this)}),this;g.closest(&quot;.fht-table-wrapper&quot;).hide();c.isFunction(b)&amp;&amp;b.call(this);return this},destroy:function(){var a=c(this),d=a.closest(&quot;.fht-table-wrapper&quot;);a.insertBefore(d).removeAttr(&quot;style&quot;).append(d.find(&quot;tfoot&quot;)).removeClass(&quot;fht-table fht-table-init&quot;).find(&quot;.fht-cell&quot;).remove();d.remove();return this}},h={_isTable:function(a){var d=a.is(&quot;table&quot;),b=0&lt;a.find(&quot;thead&quot;).length;a=0&lt;a.find(&quot;tbody&quot;).length;return d&amp;&amp;b&amp;&amp;a?!0:!1},_bindScroll:function(a){var d= a.closest(&quot;.fht-table-wrapper&quot;),c=a.siblings(&quot;.fht-thead&quot;),g=a.siblings(&quot;.fht-tfoot&quot;);a.bind(&quot;scroll&quot;,function(){0&lt;b.fixedColumns&amp;&amp;d.find(&quot;.fht-fixed-column&quot;).find(&quot;.fht-tbody table&quot;).css({&quot;margin-top&quot;:-a.scrollTop()});c.find(&quot;table&quot;).css({&quot;margin-left&quot;:-this.scrollLeft});(b.footer||b.cloneHeadToFoot)&amp;&amp;g.find(&quot;table&quot;).css({&quot;margin-left&quot;:-this.scrollLeft})})},_fixHeightWithCss:function(a,d){b.includePadding?a.css({height:a.height()+d.border}):a.css({height:a.parent().height()+d.border})},_fixWidthWithCss:function(a, d,e){b.includePadding?a.each(function(){c(this).css({width:void 0==e?c(this).width():e})}):a.each(function(){c(this).css({width:void 0==e?c(this).parent().width():e})})},_setupFixedColumn:function(a,d,e){var g=a.closest(&quot;.fht-table-wrapper&quot;),f=g.find(&quot;.fht-fixed-body&quot;);d=g.find(&quot;.fht-fixed-column&quot;);var k=c(&#39;&lt;div class=&quot;fht-thead&quot;&gt;&lt;table class=&quot;fht-table&quot;&gt;&lt;thead&gt;&lt;tr&gt;&lt;/tr&gt;&lt;/thead&gt;&lt;/table&gt;&lt;/div&gt;&#39;),p=c(&#39;&lt;div class=&quot;fht-tbody&quot;&gt;&lt;table class=&quot;fht-table&quot;&gt;&lt;tbody&gt;&lt;/tbody&gt;&lt;/table&gt;&lt;/div&gt;&#39;);a=c(&#39;&lt;div class=&quot;fht-tfoot&quot;&gt;&lt;table class=&quot;fht-table&quot;&gt;&lt;tfoot&gt;&lt;tr&gt;&lt;/tr&gt;&lt;/tfoot&gt;&lt;/table&gt;&lt;/div&gt;&#39;); var g=g.width(),l=f.find(&quot;.fht-tbody&quot;).height()-b.scrollbarOffset,q,t,r,s;k.find(&quot;table.fht-table&quot;).addClass(b.originalTable.attr(&quot;class&quot;));p.find(&quot;table.fht-table&quot;).addClass(b.originalTable.attr(&quot;class&quot;));a.find(&quot;table.fht-table&quot;).addClass(b.originalTable.attr(&quot;class&quot;));q=f.find(&quot;.fht-thead thead tr &gt; *:lt(&quot;+b.fixedColumns+&quot;)&quot;);r=b.fixedColumns*e.border;q.each(function(){r+=c(this).outerWidth(!0)});h._fixHeightWithCss(q,e);h._fixWidthWithCss(q,e);var m=[];q.each(function(){m.push(c(this).width())}); t=f.find(&quot;tbody tr &gt; *:not(:nth-child(n+&quot;+(b.fixedColumns+1)+&quot;))&quot;).each(function(a){h._fixHeightWithCss(c(this),e);h._fixWidthWithCss(c(this),e,m[a%b.fixedColumns])});k.appendTo(d).find(&quot;tr&quot;).append(q.clone());p.appendTo(d).css({&quot;margin-top&quot;:-1,height:l+e.border});t.each(function(a){0==a%b.fixedColumns&amp;&amp;(s=c(&quot;&lt;tr&gt;&lt;/tr&gt;&quot;).appendTo(p.find(&quot;tbody&quot;)),b.altClass&amp;&amp;c(this).parent().hasClass(b.altClass)&amp;&amp;s.addClass(b.altClass));c(this).clone().appendTo(s)});d.css({height:0,width:r});var n=d.find(&quot;.fht-tbody .fht-table&quot;).height()- d.find(&quot;.fht-tbody&quot;).height();d.find(&quot;.fht-tbody .fht-table&quot;).bind(&quot;mousewheel&quot;,function(a,d,b,e){if(0!=e)return a=parseInt(c(this).css(&quot;marginTop&quot;),10)+(0&lt;e?120:-120),0&lt;a&amp;&amp;(a=0),a&lt;-n&amp;&amp;(a=-n),c(this).css(&quot;marginTop&quot;,a),f.find(&quot;.fht-tbody&quot;).scrollTop(-a).scroll(),!1});f.css({width:g});if(!0==b.footer||!0==b.cloneHeadToFoot)k=f.find(&quot;.fht-tfoot tr &gt; *:lt(&quot;+b.fixedColumns+&quot;)&quot;),h._fixHeightWithCss(k,e),a.appendTo(d).find(&quot;tr&quot;).append(k.clone()),d=a.find(&quot;table&quot;).innerWidth(),a.css({top:b.scrollbarOffset, width:d})},_setupTableFooter:function(a,d,e){d=a.closest(&quot;.fht-table-wrapper&quot;);var g=a.find(&quot;tfoot&quot;);a=d.find(&quot;div.fht-tfoot&quot;);a.length||(a=0&lt;b.fixedColumns?c(&#39;&lt;div class=&quot;fht-tfoot&quot;&gt;&lt;table class=&quot;fht-table&quot;&gt;&lt;/table&gt;&lt;/div&gt;&#39;).appendTo(d.find(&quot;.fht-fixed-body&quot;)):c(&#39;&lt;div class=&quot;fht-tfoot&quot;&gt;&lt;table class=&quot;fht-table&quot;&gt;&lt;/table&gt;&lt;/div&gt;&#39;).appendTo(d));a.find(&quot;table.fht-table&quot;).addClass(b.originalTable.attr(&quot;class&quot;));switch(!0){case !g.length&amp;&amp;!0==b.cloneHeadToFoot&amp;&amp;!0==b.footer:e=d.find(&quot;div.fht-thead&quot;);a.empty(); e.find(&quot;table&quot;).clone().appendTo(a);break;case g.length&amp;&amp;!1==b.cloneHeadToFoot&amp;&amp;!0==b.footer:a.find(&quot;table&quot;).append(g).css({&quot;margin-top&quot;:-e.border}),h._setupClone(a,e.tfoot)}},_getTableProps:function(a){var d={thead:{},tbody:{},tfoot:{},border:0},c=1;!0==b.borderCollapse&amp;&amp;(c=2);d.border=(a.find(&quot;th:first-child&quot;).outerWidth()-a.find(&quot;th:first-child&quot;).innerWidth())/c;d.thead=h._getColumnsWidth(a.find(&quot;thead tr&quot;));d.tfoot=h._getColumnsWidth(a.find(&quot;tfoot tr&quot;));d.tbody=h._getColumnsWidth(a.find(&quot;tbody tr&quot;)); return d},_getColumnsWidth:function(a){var d={},b={},g=0,f,k;f=h._getColumnsCount(a);for(k=0;k&lt;f;k++)b[k]={rowspan:1,colspan:1};a.each(function(a){var l=0,k=0;c(this).children().each(function(a){for(var f=parseInt(c(this).attr(&quot;colspan&quot;))||1,h=parseInt(c(this).attr(&quot;rowspan&quot;))||1;1&lt;b[a+k].rowspan;)b[a+k].rowspan--,k+=b[a].colspan;a+=l+k;l+=f-1;1&lt;h&amp;&amp;(b[a]={rowspan:h,colspan:f});if(&quot;undefined&quot;===typeof d[a]||1!=d[a].colspan)d[a]={width:c(this).width()+parseInt(c(this).css(&quot;border-left-width&quot;))+parseInt(c(this).css(&quot;border-right-width&quot;)), colspan:f},1==f&amp;&amp;g++});if(g==f)return!1});return d},_getColumnsCount:function(a){var b=0;a.each(function(a){var g;c(this).children().each(function(a){a=parseInt(c(this).attr(&quot;colspan&quot;))||1;g=parseInt(c(this).attr(&quot;rowspan&quot;))||1;b+=a});if(1&lt;b||1==g)return!1});return b},_setupClone:function(a,d){var e=a.find(&quot;thead&quot;).length?&quot;thead tr&quot;:a.find(&quot;tfoot&quot;).length?&quot;tfoot tr&quot;:&quot;tbody tr&quot;,g={},e=a.find(e);columnsCount=h._getColumnsCount(e);for(i=0;i&lt;columnsCount;i++)g[i]={rowspan:1,colspan:1};e.each(function(a){var e= 0,h=0;c(this).children().each(function(a){for(var f=parseInt(c(this).attr(&quot;colspan&quot;))||1,m=parseInt(c(this).attr(&quot;rowspan&quot;))||1;1&lt;g[a+h].rowspan;)g[a+h].rowspan--,h+=g[a].colspan;a+=e+h;e+=f-1;1&lt;m&amp;&amp;(g[a]={rowspan:m,colspan:f});&quot;undefined&quot;!==typeof d[a]&amp;&amp;d[a].colspan==f&amp;&amp;((c(this).find(&quot;div.fht-cell&quot;).length?c(this).find(&quot;div.fht-cell&quot;):c(&#39;&lt;div class=&quot;fht-cell&quot;&gt;&lt;/div&gt;&#39;).appendTo(c(this))).css({width:parseInt(d[a].width,10)}),c(this).closest(&quot;.fht-tbody&quot;).length||!c(this).is(&quot;:last-child&quot;)||c(this).closest(&quot;.fht-fixed-column&quot;).length|| (a=Math.max((c(this).innerWidth()-c(this).width())/2,b.scrollbarOffset),c(this).css({&quot;padding-right&quot;:parseInt(c(this).css(&quot;padding-right&quot;))+a+&quot;px&quot;})))})})},_isPaddingIncludedWithWidth:function(){var a=c(&#39;&lt;table class=&quot;fht-table&quot;&gt;&lt;tr&gt;&lt;td style=&quot;padding: 10px; font-size: 10px;&quot;&gt;test&lt;/td&gt;&lt;/tr&gt;&lt;/table&gt;&#39;),d,e;a.addClass(b.originalTable.attr(&quot;class&quot;));a.appendTo(&quot;body&quot;);d=a.find(&quot;td&quot;).height();a.find(&quot;td&quot;).css(&quot;height&quot;,a.find(&quot;tr&quot;).height());e=a.find(&quot;td&quot;).height();a.remove();return d!=e?!0:!1},_getScrollbarWidth:function(){var a= 0;if(!a)if(/msie/.test(navigator.userAgent.toLowerCase())){var b=c(&#39;&lt;textarea cols=&quot;10&quot; rows=&quot;2&quot;&gt;&lt;/textarea&gt;&#39;).css({position:&quot;absolute&quot;,top:-1E3,left:-1E3}).appendTo(&quot;body&quot;),e=c(&#39;&lt;textarea cols=&quot;10&quot; rows=&quot;2&quot; style=&quot;overflow: hidden;&quot;&gt;&lt;/textarea&gt;&#39;).css({position:&quot;absolute&quot;,top:-1E3,left:-1E3}).appendTo(&quot;body&quot;),a=b.width()-e.width()+2;b.add(e).remove()}else b=c(&quot;&lt;div /&gt;&quot;).css({width:100,height:100,overflow:&quot;auto&quot;,position:&quot;absolute&quot;,top:-1E3,left:-1E3}).prependTo(&quot;body&quot;).append(&quot;&lt;div /&gt;&quot;).find(&quot;div&quot;).css({width:&quot;100%&quot;, height:200}),a=100-b.width(),b.parent().remove();return a}};if(n[m])return n[m].apply(this,Array.prototype.slice.call(arguments,1));if(&quot;object&quot;!==typeof m&amp;&amp;m)c.error(&#39;Method &quot;&#39;+m+&#39;&quot; does not exist in fixedHeaderTable plugin!&#39;);else return n.init.apply(this,arguments)}})(jQuery);</span></td>
      </tr>
      <tr>
        <td id="L20" class="blob-num js-line-number" data-line-number="20"></td>
        <td id="LC20" class="blob-code blob-code-inner js-file-line"><span class="pl-c"></span></td>
      </tr>
</table>

  </div>

</div>

<button type="button" data-facebox="#jump-to-line" data-facebox-class="linejump" data-hotkey="l" class="hidden">Jump to Line</button>
<div id="jump-to-line" style="display:none">
  <!-- </textarea> --><!-- '"` --><form accept-charset="UTF-8" action="" class="js-jump-to-line-form" method="get"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /></div>
    <input class="form-control linejump-input js-jump-to-line-field" type="text" placeholder="Jump to line&hellip;" aria-label="Jump to line" autofocus>
    <button type="submit" class="btn">Go</button>
</form></div>

  </div>
  <div class="modal-backdrop"></div>
</div>


    </div>
  </div>

    </div>

        <div class="container site-footer-container">
  <div class="site-footer" role="contentinfo">
    <ul class="site-footer-links right">
        <li><a href="https://status.github.com/" data-ga-click="Footer, go to status, text:status">Status</a></li>
      <li><a href="https://developer.github.com" data-ga-click="Footer, go to api, text:api">API</a></li>
      <li><a href="https://training.github.com" data-ga-click="Footer, go to training, text:training">Training</a></li>
      <li><a href="https://shop.github.com" data-ga-click="Footer, go to shop, text:shop">Shop</a></li>
        <li><a href="https://github.com/blog" data-ga-click="Footer, go to blog, text:blog">Blog</a></li>
        <li><a href="https://github.com/about" data-ga-click="Footer, go to about, text:about">About</a></li>

    </ul>

    <a href="https://github.com" aria-label="Homepage" class="site-footer-mark" title="GitHub">
      <svg aria-hidden="true" class="octicon octicon-mark-github" height="24" version="1.1" viewBox="0 0 16 16" width="24"><path d="M8 0C3.58 0 0 3.58 0 8c0 3.54 2.29 6.53 5.47 7.59 0.4 0.07 0.55-0.17 0.55-0.38 0-0.19-0.01-0.82-0.01-1.49-2.01 0.37-2.53-0.49-2.69-0.94-0.09-0.23-0.48-0.94-0.82-1.13-0.28-0.15-0.68-0.52-0.01-0.53 0.63-0.01 1.08 0.58 1.23 0.82 0.72 1.21 1.87 0.87 2.33 0.66 0.07-0.52 0.28-0.87 0.51-1.07-1.78-0.2-3.64-0.89-3.64-3.95 0-0.87 0.31-1.59 0.82-2.15-0.08-0.2-0.36-1.02 0.08-2.12 0 0 0.67-0.21 2.2 0.82 0.64-0.18 1.32-0.27 2-0.27 0.68 0 1.36 0.09 2 0.27 1.53-1.04 2.2-0.82 2.2-0.82 0.44 1.1 0.16 1.92 0.08 2.12 0.51 0.56 0.82 1.27 0.82 2.15 0 3.07-1.87 3.75-3.65 3.95 0.29 0.25 0.54 0.73 0.54 1.48 0 1.07-0.01 1.93-0.01 2.2 0 0.21 0.15 0.46 0.55 0.38C13.71 14.53 16 11.53 16 8 16 3.58 12.42 0 8 0z"></path></svg>
</a>
    <ul class="site-footer-links">
      <li>&copy; 2016 <span title="0.05156s from github-fe147-cp1-prd.iad.github.net">GitHub</span>, Inc.</li>
        <li><a href="https://github.com/site/terms" data-ga-click="Footer, go to terms, text:terms">Terms</a></li>
        <li><a href="https://github.com/site/privacy" data-ga-click="Footer, go to privacy, text:privacy">Privacy</a></li>
        <li><a href="https://github.com/security" data-ga-click="Footer, go to security, text:security">Security</a></li>
        <li><a href="https://github.com/contact" data-ga-click="Footer, go to contact, text:contact">Contact</a></li>
        <li><a href="https://help.github.com" data-ga-click="Footer, go to help, text:help">Help</a></li>
    </ul>
  </div>
</div>



    
    

    <div id="ajax-error-message" class="ajax-error-message flash flash-error">
      <svg aria-hidden="true" class="octicon octicon-alert" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path d="M15.72 12.5l-6.85-11.98C8.69 0.21 8.36 0.02 8 0.02s-0.69 0.19-0.87 0.5l-6.85 11.98c-0.18 0.31-0.18 0.69 0 1C0.47 13.81 0.8 14 1.15 14h13.7c0.36 0 0.69-0.19 0.86-0.5S15.89 12.81 15.72 12.5zM9 12H7V10h2V12zM9 9H7V5h2V9z"></path></svg>
      <button type="button" class="flash-close js-flash-close js-ajax-error-dismiss" aria-label="Dismiss error">
        <svg aria-hidden="true" class="octicon octicon-x" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path d="M7.48 8l3.75 3.75-1.48 1.48-3.75-3.75-3.75 3.75-1.48-1.48 3.75-3.75L0.77 4.25l1.48-1.48 3.75 3.75 3.75-3.75 1.48 1.48-3.75 3.75z"></path></svg>
      </button>
      Something went wrong with that request. Please try again.
    </div>


      
      <script crossorigin="anonymous" integrity="sha256-MC9IAFcXhUVzZ5moQ0qNGdI4Uy3Ab0vqyuVgz1p/Q3Y=" src="https://assets-cdn.github.com/assets/frameworks-302f480057178545736799a8434a8d19d238532dc06f4beacae560cf5a7f4376.js"></script>
      <script async="async" crossorigin="anonymous" integrity="sha256-+Dri8NSD3dyPGJSzzCcJ/x20hRHdyNBU7WOcUsgNVMk=" src="https://assets-cdn.github.com/assets/github-f83ae2f0d483dddc8f1894b3cc2709ff1db48511ddc8d054ed639c52c80d54c9.js"></script>
      
      
      
      
      
      
    <div class="js-stale-session-flash stale-session-flash flash flash-warn flash-banner hidden">
      <svg aria-hidden="true" class="octicon octicon-alert" height="16" version="1.1" viewBox="0 0 16 16" width="16"><path d="M15.72 12.5l-6.85-11.98C8.69 0.21 8.36 0.02 8 0.02s-0.69 0.19-0.87 0.5l-6.85 11.98c-0.18 0.31-0.18 0.69 0 1C0.47 13.81 0.8 14 1.15 14h13.7c0.36 0 0.69-0.19 0.86-0.5S15.89 12.81 15.72 12.5zM9 12H7V10h2V12zM9 9H7V5h2V9z"></path></svg>
      <span class="signed-in-tab-flash">You signed in with another tab or window. <a href="">Reload</a> to refresh your session.</span>
      <span class="signed-out-tab-flash">You signed out in another tab or window. <a href="">Reload</a> to refresh your session.</span>
    </div>
    <div class="facebox" id="facebox" style="display:none;">
  <div class="facebox-popup">
    <div class="facebox-content" role="dialog" aria-labelledby="facebox-header" aria-describedby="facebox-description">
    </div>
    <button type="button" class="facebox-close js-facebox-close" aria-label="Close modal">
      <svg aria-hidden="true" class="octicon octicon-x" height="16" version="1.1" viewBox="0 0 12 16" width="12"><path d="M7.48 8l3.75 3.75-1.48 1.48-3.75-3.75-3.75 3.75-1.48-1.48 3.75-3.75L0.77 4.25l1.48-1.48 3.75 3.75 3.75-3.75 1.48 1.48-3.75 3.75z"></path></svg>
    </button>
  </div>
</div>

  </body>
</html>

