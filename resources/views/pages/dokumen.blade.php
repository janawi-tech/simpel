@extends('admin-template')
@section('content')
                  <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">LPFK BJB</a></li>
                                    <li class="breadcrumb-item active">Bukti Upload Dokumen</li>
                                </ol>
                            </div>
                            <h4 class="page-title">&nbsp;</h4>
                        </div>
                    </div>
                </div>

                <div class="row">
                  <div class="col-md-12">
                    <div class="card m-b-30">
                            <div class="card-header">
                                <button type="button" class="btn btn-gradient waves-light waves-effect w-md" id="btn-add">Tambah Data</button>
                            </div>
                            <div class="card-body">
                                <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="tabledokumen">
                                  <thead>
                                    <tr>
                                      <th>No</th>
                                      <th>No Order</th>
                                      <th>Tahun</th>
                                      <th>Dokumen 1</th>
                                      <th>Dokumen 2</th>
                                      <th>Action</th>
                                    </tr>
                                  </thead>
                                  <tfoot>
                                    <tr>
                                      <th>No</th>
                                      <th>No Order</th>
                                      <th>Tahun</th>
                                      <th>Dokumen 1</th>
                                      <th>Dokumen 2</th>
                                      <th>Action</th>
                                    </tr>
                                  </tfoot>
                                </table>

                                <!-- Modal -->
                                  <div class="modal fade modal-rotate-from-bottom" id="myModal" aria-hidden="true" aria-labelledby="exampleModalTitle" role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
                                    <div class="modal-dialog modal-simple" style="max-width: 750px">
                                      <form class="form-horizontal" id="frmbukti"  enctype="multipart/form-data">
                                      <div class="modal-content">
                                        <div class="modal-header">
                                          <button type="button" class="close tutup" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                          </button>
                                          <h4 class="modal-title">Upload Dokumen</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">No Order</label>
                                              <div class="col-md-8">
                                                <input type="hidden" class="form-control no_order" name="no_order" id="no_order" />
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Berita Acara</label>
                                              <div class="col-md-8">
                                                <input type="file" class="form-control dok1" id="dok1" name="dok1"/>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Bukti Penyerahan</label>
                                              <div class="col-md-8">
                                                <input type="file" class="form-control dok2" id="dok2" name="dok2"/>
                                              </div>
                                            </div>
                                        </div>
                                        <div class="modal-footer">
                                          <button type="submit  " class="btn btn-primary" id="btn-save" value="add">Save</button>
                                          <input type="hidden" id="id" name="id" value="0">
                                        </div>
                                      </div>
                                      </form>
                                    </div>
                                  </div>
                                  <!-- End Modal -->
                            </div>

                    </div>
                  </div>
                </div>

{!! HTML::script('js/ajax-dokumen.js') !!}
@stop
