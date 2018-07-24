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


`index/symmetric_indexing` := proc(idx::list(posint), A::Array, val::list)
    # This is a rudimentary symmetric user indexing function for
    # square Arrays of arbitrary dimension.

local idx_sorted;

    idx_sorted := sort(idx);

    if _npassed = 2 then
        A[op(idx_sorted)];
    else
        A[op(idx_sorted)] := op(val);
    end if;

end proc:


generate_indices := proc(d::posint, r::posint,
                         {symmetric::truefalse:=true}, $)
option remember;
    # Builds all the r-combinations with replacement of the integers
    # 1..d. If symmetric = false, then all r-tuples in 1..d are
    # generated.

local M;

    if symmetric then
        M := Iterator:-MultiCombination([r$d], r);
    else
        M := Iterator:-CartesianProduct([i$i=1..d]$r):
    end;

    seq(convert(m[], 'list'), m in M);

end proc:


build_array := proc(expr::algebraic, vars::list(name), r::posint,
                    {symmetric::truefalse:=true}, $)
    # This test function builds an Array for storing all rth order
    # derivatives of expr with respect to the variables in vars.
    # The indices are taken from the global variable IX, so their
    # memory consumption does not add to the memory consumption of
    # the Array.

global IX;
local A, d, idx;

    d := numelems(vars);

    if symmetric then
        A := Array(symmetric_indexing, (1..d)$r, storage=sparse[upper]);
    else
        A := Array((1..d)$r);
    end;

    for idx in IX do
        A[op(idx)] := diff(expr, seq(vars[i], i in idx));
    end do;

    return A;

end proc:


