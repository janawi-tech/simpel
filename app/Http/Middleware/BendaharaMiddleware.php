<?php

namespace App\Http\Middleware;

use Closure;

class BendaharaMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        if (auth()->user()->groups == 1 OR auth()->user()->groups == 5) {
            return $next($request);
        }


        abort(404);
    }
}
