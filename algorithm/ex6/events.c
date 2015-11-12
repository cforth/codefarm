#include <stdlib.h>
#include <string.h>
#include "event.h"
#include "events.h"
#include "queue.h"

/* receive_event */
int receive_event(Queue *events, const Event *event)
{
    Event *new_event;

    /* Allocate space for the event. */
    if ((new_event = (Event *)malloc(sizeof(Event))) == NULL)
        return -1;

    /* Make a copy of the event and enqueue it. */
    memcpy(new_event, event, sizeof(Event));

    if (queue_enqueue(events, new_event) != 0)
        return -1;

    return 0;
}


/* process_event */
int process_event(Queue *events, int (*dispatch)(Event *event))
{
    Event *event;

    if (queue_size(events) == 0)
        /* Return that there sre no events to dispatch. */
        return -1;
    else
    {
        if (queue_dequeue(events, (void **)&event) != 0)
            /* Return that an event could not be retrieved. */
            return -1;
        else
        {
            /* Call a user-defined function to dispatch the event. */
            dispatch(event);
            free(event);
        }
    }
    return 0;
}
