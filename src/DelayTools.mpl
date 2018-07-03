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
# along with DelayTools.  If not, see <https://www.gnu.org/licenses/>.


DelayTools := module()
    option package;
    export mlindex, mldiff, DDE;
    local number_of_args;


$include "DDE.mpl"


    mlindex := proc(d::posint, r::posint, $)::listlist;
        option remember;
        # Recursively build a list containing d^r sublists. Each of
        # these sublists is of the form [i[1],..,i[r]] where every
        # element is in the range 1..d.

        local i, j;

        if r = 1 then
            return [[i] $ i = 1..d];
        else
            return ['seq([i, op(j)], j in mlindex(d, r - 1))' $ i = 1..d];
        end if;
    end proc;


    mldiff := proc(f, r::posint, v::list, $)::list;
        # Calculate the derivative of order r of the function f, at
        # the origin, and apply the resulting r-linear form to v.

        local d, idx, i, s;

        if numelems(v) <> r then
            error("An r-linear form requires r arguments.");
        end;

        d := number_of_args(f);
        idx := mlindex(d, r);
        add(D[op(i)](f)(0$d)*~mul(v[s][i[s]], s = 1..r), i in idx);
    end proc;


    number_of_args := proc(f::list, $)::posint;
        option remember;
        # Compute the number of arguments of f, where f is assumed to
        # have the form of a list of component functions.

        local component_args;

        component_args := {'[op(1, f[j])]' $ j = 1..numelems(f)};
        if numelems(component_args) > 1 then
            error("Components of f must all have equal number of arguments");
        end;

        return numelems(component_args[1]);
    end


end module;
