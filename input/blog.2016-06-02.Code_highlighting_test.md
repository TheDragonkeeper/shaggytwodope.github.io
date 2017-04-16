description: A test post for highlighting code.
---
# {{ page.post }} Posted on {{ page.date }}

Here is some code from a header file for a project I created.
It's part of a simple tool to launch a single program that is
predefined in the line `#define DEFAULT_RUN_COMMAND "lite-controlcenter"`.
There is little use for this. This entire post is just to test things.

<pre><code class="language-c">
/*
* Copyright © 2016 Johnathan "Shaggytwodope" Jenkins <twodopeshaggy@gmail.com>
*
* Distributed under terms of the GPL2 license.
*/

#ifndef SRC_HEADERS_LITECC_H_
#define SRC_HEADERS_LITECC_H_

G_BEGIN_DECLS

#define DEFAULT_ICON_NAME "lite-controlcenter"
#define DEFAULT_TOOLTIP_MESSAGE "Linux Lite Control Center"
#define DEFAULT_RUN_COMMAND "lite-controlcenter"

typedef struct _LccPlugin {
    XfcePanelPlugin *plugin;

    GtkWidget       *button;
    GtkWidget       *icon;

    gchar           *icon_name;
}
LccPlugin;


G_END_DECLS


#endif /* SRC_HEADERS_LITECC_H_ */
</code></pre>




You can find it [here](https://github.com/shaggytwodope/litecontrolcenterapplet)
or even check out my [projects](/projects.html) page
for way more stuff I've created. 
