@extends('admin-template')
@section('content')
        <!-- Page-Title -->
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">LPFK BJB</a></li>
                                    <li class="breadcrumb-item active">Rekap Data Per Provinsi</li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end page title end breadcrumb -->


                <div class="row">
                    <div class="col-md-12">
                        <div class="card-box">
                            <div class="dx-viewport demo-container">
                                <div id="grid"></div>
                            </div>
                        </div>
                    </div>
                </div>
{!! HTML::script('js/ajax-rekap-prov.js') !!}
@stop
