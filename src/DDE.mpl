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


DDE := module()
    option package;
    export sys_to_f, eval_at_delays, diff_at_zero, char_matrix;


    sys_to_f := proc(sys, vars::list, delays::list)::list;
        # Convert the "natural" specification sys of the right-hand
        # side of the DDE to a functional form that is suitable as
        # input for the other procedures. The output is a list of
        # component functions.

        local s, fexpr, new_vars;

        s := [seq(seq(v(t - tau) = cat(v, tau), v in vars), tau in delays)];
        fexpr := map2(applyrule, s, sys);
        new_vars := map2(op, 2, s);
        return map(unapply, fexpr, new_vars);
    end proc;


    eval_at_delays := proc(phi, delays::list, $)::list;
        # Evaluate phi at minus each delay in the list. If phi has n
        # components and there are m + 1 delays - including the zero
        # delay - then the resulting n by (m + 1) matrix is returned
        # in column-major order as a flattened list. This makes it
        # easier to use the result as input for function evaluation.

        local phi_at_delays;

        phi_at_delays := map(phi, -delays);
        return map(op, map(convert, phi_at_delays, 'list'));
    end proc;


    diff_at_zero := proc(f, E, r::posint, argfuncs::list, $)::list;
        # Calculate the rth order derivative of F at zero and apply
        # the result to r argument functions.

        return mldiff(f, r, map(E, argfuncs));
    end proc;


    char_matrix := proc(f, E, $)::operator;
        # Construct the characteristic matrix function for the
        # linearization at the origin. For this compute the Laplace
        # transform of the NBV-kernel by applying DF(0) to suitably
        # chosen argument functions.
        # Since the differentiation procedure returns a list and lists
        # become row vectors in the Matrix constructor, we need to do
        # a transposition at the end.

        uses LinearAlgebra;
        local d, n, z, psi, L;

        # Recover the system dimension n from f.
        n := numelems(f);

        psi := ['theta -> exp(z*theta)*UnitVector(j, n)' $ 'j' = 1..n];
        L := Matrix(['diff_at_zero(f, E, 1, [psi[j]])' $ j = 1..n]);
        Transpose(L, inplace = true);

        return unapply(z*IdentityMatrix(n) - L, z);
    end proc;


end module;
