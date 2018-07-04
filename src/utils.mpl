# Copyright 2018 Sebastiaan G. Janssens

# This file is part of DelayTools.
#
# DelayTools is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# DelayTools is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with DelayTools. If not, see <https://www.gnu.org/licenses/>.


utils := module()


export number_of_args;


    number_of_args := proc(f::list, $)::posint;
    option remember;
        # Compute the number of arguments of f, where f is assumed to
        # have the form of a list of component functions. Check that
        # all component functions have an equal number of arguments.

    local component_args;

        component_args := {'[op(1, f[j])]' $ j = 1..numelems(f)};
        if numelems(component_args) > 1 then
            error("Components of f must all have equal number of arguments");
        end;

        return numelems(component_args[1]);
    end


end module;
