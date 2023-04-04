<%
    from codegen.utilities.attribute_helpers import get_attributes, get_enums_used, transform_attributes
    from codegen.utilities.text_wrappers import wrap
    attributes = get_attributes(data, "ExpirationState")
    attributes =  transform_attributes(attributes, "ExpirationState")
    enums_used = get_enums_used(attributes)
%>\
# Do not edit this file; it was automatically generated.

import ctypes
import deprecation

from nidaqmx._lib import lib_importer, ctypes_byte_str
from nidaqmx.errors import (
    check_for_error, is_string_buffer_too_small, is_array_buffer_too_small)
from nidaqmx.constants import (
    ${', '.join([c for c in enums_used]) | wrap(4, 4)})


class ExpirationState:
    """
    Represents a DAQmx Watchdog expiration state.
    """
    def __init__(self, task_handle, physical_channel):
        self._handle = task_handle
        self._physical_channel = physical_channel

    def __eq__(self, other):
        if isinstance(other, self.__class__):
            return (self._handle == other._handle and
                    self._physical_channel == other._physical_channel)
        return False

    def __hash__(self):
        return hash((self._handle.value, self._physical_channel))

    def __ne__(self, other):
        return not self.__eq__(other)

<%namespace name="property_template" file="/property_template.py.mako"/>\
%for attribute in attributes:
${property_template.script_property(attribute)}\
%endfor
<%namespace name="deprecated_template" file="/property_deprecated_template.py.mako"/>\
${deprecated_template.script_deprecated_property(attributes)}\
