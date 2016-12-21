#-------------------------------------------------------------------------
#------------------- General configuration -------------------------------
#-------------------------------------------------------------------------

project   = u'Virgil Security Documentation'
copyright = u'2016, Virgil Security, Inc'
author    = u'Virgil Security, Inc.'

source_suffix = '.rst'
master_doc    = 'index'

templates_path = [
    'pages',
    'templates'
]


exclude_patterns = [
     'cli/v3*'
]

#-------------------------------------------------------------------------
#------------------- Extensions configuration ----------------------------
#-------------------------------------------------------------------------

extensions = [
#   'sphinx.ext.viewcode',
#   'sphinxcontrib.httpdomain',
#   'sphinxcontrib.jsoncall'
]

# jsoncall_baseurl = 'https://identity.virgilsecurity.com/v1'

#-------------------------------------------------------------------------
#------------------- Options for HTML output -----------------------------
#-------------------------------------------------------------------------

html_theme         = 'sphinx_virgil_theme'
html_theme_options = {}

html_theme_path    = [
    './_themes'
]

html_static_path = [
    '_static'
]

html_extra_path = [
    'extra'
]

html_additional_pages = {
    'index'    : 'pages/custom-index.html',
#   'sdk/sdks' : 'pages/custom-sdk.html'
}

html_sidebars = {
    '**': ['searchbox.html', 'localtoc.html', 'sourcelink.html']
#   'index': ['index_sidebar.html'],
}

html_title         = u'Virgil Security Documentation'
html_short_title   = u'Documentation'
html_favicon       = './images/favicon.ico'
html_logo          = './images/logo.png'

html_copy_source       = True
html_domain_indices    = True
html_split_index       = False
html_show_sourcelink   = True
html_add_permalinks    = False

html_scaled_image_link = False
html_use_smartypants   = False
html_compact_lists     = True

html_show_sphinx       = False
html_show_copyright    = False

