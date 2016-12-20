# -- General configuration ------------------------------------------------

# General information about the project.
project = u'Virgil Security Docs'
copyright = u'2016, Virgil Security, Inc'
author = u'Virgil Security, Inc.'

extensions = [
    'sphinx.ext.viewcode',
#    'sphinxcontrib.httpdomain',
#    'sphinxcontrib.jsoncall'
]

templates_path = [ 'pages' ]
source_suffix = '.rst'
master_doc = 'index'

exclude_patterns = [
    'cli/v3*'
]


# -- Options for HTML output ----------------------------------------------


html_theme_path = ["./_themes"]
html_theme = 'sphinx_virgil_theme'
html_theme_options = {}

html_title = u'Virgil Security Docs'
html_short_title = u'Virgil Security Docs'
html_logo = "./images/logo.png"
html_favicon = "./images/favicon.ico"

html_static_path = ['_static']

# Add any extra paths that contain custom files (such as robots.txt or .htaccess) here, relative to this directory.
html_extra_path = []

# Additional templates that should be rendered to pages, maps page names to template names.
html_additional_pages = {
    'index' : 'pages/custom-index.html'
#   'sdk/sdks' : 'pages/custom-sdk.html'
}

html_copy_source = False

html_show_sphinx = False
html_show_copyright = True

# html_use_opensearch = ''
html_search_language = 'en'


jsoncall_baseurl = 'https://identity.virgilsecurity.com/v1'

htmlhelp_basename = 'VirgilDocsdoc'


# -- Options for manual page output ---------------------------------------

# One entry per manual page. List of tuples (source start file, name, description, authors, manual section).
man_pages = [
    (master_doc, 'virgildocs', u'Virgil Security Documentation', [author], 1)
]

man_show_urls = False


# -- Options for Texinfo output -------------------------------------------

# Grouping the document tree into Texinfo files. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
    (master_doc, 'VirgilDocs', u'Virgil Security Documentation',
     author, 'VirgilDocs', 'One line description of project.',
     'Miscellaneous'),
]

# Documents to append as an appendix to all manuals.
#
# texinfo_appendices = []

# If false, no module index is generated.
#
# texinfo_domain_indices = True

# How to display URL addresses: 'footnote', 'no', or 'inline'.
#
# texinfo_show_urls = 'footnote'

# If true, do not generate a @detailmenu in the "Top" node's menu.
#
# texinfo_no_detailmenu = False


# Example configuration for intersphinx: refer to the Python standard library.
intersphinx_mapping = {'https://docs.python.org/': None}
