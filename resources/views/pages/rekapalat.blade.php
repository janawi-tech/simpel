@extends('admin-template')
@section('content')
                  <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">LPFK BJB</a></li>
                                    <li class="breadcrumb-item active">Rekap Alat yang Terkalibrasi</li>
                                </ol>
                            </div>
                            <h4 class="page-title">&nbsp;</h4>
                        </div>
                    </div>
                </div>

                <div class="row">
                  <div class="col-md-12">
                    <div class="card m-b-30">
                            <div class="card-body">
                                <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="tablerekap">
                                  <thead>
                                    <tr>
                                      <th>Tahun</th>
                                      <th>Nama Alat</th>
                                      <th>Jumlah</th>
                                    </tr>
                                  </thead>
                                  <tfoot>
                                    <tr>
                                      <th>Tahun</th>
                                      <th>Nama Alat</th>
                                      <th>Jumlah</th>
                                    </tr>
                                  </tfoot>
                                </table>
                            </div>

                    </div>
                  </div>
                </div>

{!! HTML::script('js/ajax-rekapalat.js') !!}
@stop
