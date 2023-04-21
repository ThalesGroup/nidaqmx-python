<%
    from codegen.utilities.text_wrappers import wrap
    from codegen.utilities.function_helpers import get_functions,  get_enums_used
    functions = get_functions(data, "COChannelCollection")
    enums_used = get_enums_used(functions)
%>\
# Do not edit this file; it was automatically generated.

import ctypes
import numpy

from nidaqmx._lib import lib_importer, ctypes_byte_str
from nidaqmx.errors import check_for_error
from nidaqmx._task_modules.channels.co_channel import COChannel
from nidaqmx._task_modules.channel_collection import ChannelCollection
from nidaqmx.utils import unflatten_channel_string
%if enums_used:
from nidaqmx.constants import (
    ${', '.join([c for c in enums_used]) | wrap(4, 4)})
%endif


class COChannelCollection(ChannelCollection):
    """
    Contains the collection of counter output channels for a DAQmx Task.
    """
    def __init__(self, task_handle, interpreter):
        """
        Do not construct this object directly; instead, construct a nidaqmx.Task and use the task.co_channels property.
        """
        super().__init__(task_handle, interpreter)

    def _create_chan(self, counter, name_to_assign_to_channel=''):
        """
        Creates and returns a COChannel object.

        Args:
            counter (str): Specifies the names of the counters to use to 
                create virtual channels.
            name_to_assign_to_channel (Optional[str]): Specifies a name to 
                assign to the virtual channel this method creates.
        Returns:
            nidaqmx._task_modules.channels.co_channel.COChannel: 
            
            Specifies the newly created COChannel object.
        """
        if name_to_assign_to_channel:
            num_counters = len(unflatten_channel_string(counter))

            if num_counters > 1:
                name = '{}0:{}'.format(
                    name_to_assign_to_channel, num_counters-1)
            else:
                name = name_to_assign_to_channel
        else:
            name = counter

        return COChannel(self._handle, name, self._interpreter)

<%namespace name="function_template" file="/function_template.py.mako"/>\
%for function_object in functions:
${function_template.script_function(function_object)}
%endfor