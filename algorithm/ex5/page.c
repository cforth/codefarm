#include "clist.h"
#include "page.h"

/* replace_pages */
int replace_page(CListElmt **current)
{
    /* Circle through the list of pages until one is found to replace. */
    while (((Page *)(*current)->data)->reference != 0)
    {
        ((Page *)(*current)->data)->reference = 0;
        *current = clist_next(*current);
    }
    
    return ((Page *)(*current)->data)->number;
}
