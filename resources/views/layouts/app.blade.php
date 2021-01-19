<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <link rel="icon" href="../assets/images/favicon.ico"> 
    <title>.:: Login Sistem ::.</title>
    {!! HTML::style('assets/css/bootstrap.min.css') !!}
    {!! HTML::style('assets/css/icons.css') !!}
    {!! HTML::style('assets/css/style.css') !!}

    {!! HTML::script('assets/js/modernizr.min.js') !!}
   
</head>

<body class="bg-accpunt-pages">

    @yield('content')

</body>
</html>
