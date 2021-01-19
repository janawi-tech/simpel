<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <title>.:: BPFK Banjarbaru ::.</title>
    <link rel="icon" href="../img/favicon.ico"> 
    <meta name="_token" content="{!! csrf_token() !!}" />
    <!-- App favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico">
        
        @if (in_array(Route::currentRouteName(),['page.pengguna','page.penerimaan','page.spk','page.penyerahan','page.bukti','page.dokumen','page.kuitansi','page.rekap-provinsi','page.rekap-kabupaten']))
        {!! HTML::style('assets/plugins/datatables/dataTables.bootstrap4.min.css') !!}
        {!! HTML::style('assets/plugins/datatables/buttons.bootstrap4.min.css') !!}
        <!-- Responsive datatable examples -->
        {!! HTML::style('assets/plugins/datatables/responsive.bootstrap4.min.css') !!}
        {!! HTML::style('assets/plugins/dropify/dist/css/dropify.min.css') !!}
        {!! HTML::style('assets/css/select2.css') !!}
        {!! HTML::style('assets/css/bootstrap-select.min.css') !!}
        {!! HTML::style('assets/css/select2-bootstrap.css') !!}
        {!! HTML::style('assets/dev/css/dx.common.css') !!}
        {!! HTML::style('assets/dev/css/dx.light.css') !!}
        @endif
        <!-- App css -->
        {!! HTML::style('assets/css/bootstrap.min.css') !!}
        {!! HTML::style('assets/css/icons.css') !!}
        {!! HTML::style('assets/css/style.css') !!}

        {!! HTML::script('assets/js/modernizr.min.js') !!}
        {!! HTML::script('assets/js/jquery.min.js') !!}
        
        @if (in_array(Route::currentRouteName(),['admin.dashboard','page.lokasi']))
        {!! HTML::script('assets/grafik/js/echarts.min.js') !!}
        {!! HTML::script('assets/grafik/js/ecStat.min.js') !!}
        {!! HTML::script('assets/grafik/js/kab_indo.js') !!}
        {!! HTML::script('assets/grafik/js/Kalimantan.js') !!}
        {!! HTML::script('assets/grafik/js/provinsi_kalsel.js') !!}
        {!! HTML::script('assets/grafik/js/provinsi_kaltim.js') !!}
        {!! HTML::script('assets/grafik/js/provinsi_kalteng.js') !!}
        {!! HTML::script('assets/grafik/js/provinsi_kaltara.js') !!}
        {!! HTML::script('assets/grafik/js/bmap.js') !!}
        {!! HTML::script('assets/grafik/js/simplex.js') !!}
        @endif
        <style>
            .coloredRow{
                background: green;
            }
        </style>
</head>
<body>
    
     <!-- Page -->
  @include('layouts.head')
  
  <!-- Page -->
  <div class="wrapper">
    <div class="container-fluid">
      @yield('content')
    </div>
  </div>
  <!-- End Page -->
  @include('layouts.footer') 

        
        {!! HTML::script('assets/js/popper.min.js') !!}
        {!! HTML::script('assets/js/bootstrap.min.js') !!}
        {!! HTML::script('assets/js/waves.js') !!}
        {!! HTML::script('assets/js/jquery.slimscroll.js') !!}

        @if (in_array(Route::currentRouteName(),['page.pengguna','page.penerimaan','page.spk','page.penyerahan','page.bukti','page.dokumen','page.rekapalat','page.kuitansi','page.rekap-provinsi','page.rekap-kabupaten']))
        {!! HTML::script('assets/js/jquery.validate.min.js') !!}
        {!! HTML::script('assets/js/sweetalert.min.js') !!}

        {!! HTML::script('assets/js/select2.full.min.js') !!}
        {!! HTML::script('assets/js/bootstrap-select.min.js') !!}
        {!! HTML::script('assets/js/select2.min.js') !!}
        
        <!-- Required datatable js -->
        {!! HTML::script('assets/plugins/datatables/jquery.dataTables.min.js') !!}
        {!! HTML::script('assets/plugins/datatables/dataTables.bootstrap4.min.js') !!}
        {!! HTML::script('assets/plugins/datatables/dataTables.buttons.min.js') !!}
        {!! HTML::script('assets/plugins/datatables/buttons.bootstrap4.min.js') !!}
        {!! HTML::script('assets/plugins/datatables/buttons.print.min.js') !!}
        {!! HTML::script('assets/plugins/datatables/buttons.html5.min.js') !!}
        <!-- Buttons examples -->

        <!-- Responsive examples -->
        {!! HTML::script('assets/plugins/datatables/dataTables.responsive.min.js') !!}
        {!! HTML::script('assets/plugins/datatables/responsive.bootstrap4.min.js') !!}

        {!! HTML::script('assets/plugins/dropify/dist/js/dropify.min.js') !!}

        {!! HTML::script('assets/dev/js/jszip.min.js') !!}
        {!! HTML::script('assets/dev/js/dx.all.js') !!}
        {!! HTML::script('assets/dev/js/dx.aspnet.data.js') !!}
        @endif

        <!-- Counter number -->
        @if (in_array(Route::currentRouteName(),['admin.dashboard']))
        {!! HTML::script('assets/plugins/waypoints/lib/jquery.waypoints.min.js') !!}
        {!! HTML::script('assets/plugins/counterup/jquery.counterup.min.js') !!}
        @endif


        <!-- App js -->
        {!! HTML::script('assets/js/jquery.core.js') !!}
        {!! HTML::script('assets/js/jquery.app.js') !!}
</body>
</html>