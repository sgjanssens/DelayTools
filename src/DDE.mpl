# DelayTools - Copyright 2018 Sebastiaan G. Janssens

DDE := module()
    export sys_to_f, eval_at_delays, diff;


    sys_to_f := proc(sys, vars::list, delays::list)
        # Convert the "natural" specification sys of the right-hand
        # side of the DDE to the standard functional form f that is
        # suitable as input for the other procedures.

        local fargs;

        fargs := [seq(seq(v(t - tau), v in vars), tau in delays)];
        unapply(sys, map(convert, fargs, 'name'));
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


    diff := proc(f, E, r::posint, argfuncs::list, $)::Vector;
        # Calculate the rth order derivative at zero of the right-hand
        # side of a DDE and apply the result to r argument functions.

        return mldiff(f, r, map(E, argfuncs));
    end proc;


end module;
