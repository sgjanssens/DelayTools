$define CT CodeTools

# Define the test input, a function expression.
d := 10:
vars := ['cat(x, i)' $ 'i' = 1..d]:
fexpr := f(op(vars)):

# Standard rectangular indexing and rectangular storage.
IX := generate_indices(d, 5, symmetric=false):
rrdata := CT:-Usage(build_array(expr, vars, 5, symmetric=false),
                    output='all', quiet=false, iterations=10);

# Custom symmetric indexing and sparse storage.
IX := generate_indices(d, 5, symmetric=true):
ssdata := CT:-Usage(build_array(expr, vars, 5, symmetric=true),
                    output='all', quiet=false, iterations=10);

