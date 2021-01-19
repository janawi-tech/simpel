<?php

namespace App\Http\Middleware;
use Response;
use Closure;

class LabMiddleware
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
        if (auth()->user()->groups == 1 OR auth()->user()->groups == 3 OR auth()->user()->id == 9) {
            return $next($request);
        }


        abort(404);
    }
}
