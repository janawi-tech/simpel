@extends('admin-template')
@section('content')

                  <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">LPFK BJB</a></li>
                                    <li class="breadcrumb-item active">Data Penyerahan Alat dari Lab</li>
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
                                <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="tablepenyerahan">
                                  <thead>
                                    <tr>
                                      <th class="catatan">No</th>
                                      <th>Tgl Penyerahan</th>
                                      <th>No Order</th>
                                      <th>Lab</th>
                                      <th>Yantek</th>
                                      <th>Tahun</th>
                                      <th>Action</th>
                                    </tr>
                                  </thead>
                                  <tfoot>
                                    <tr>
                                      <th>No</th>
                                      <th>Tgl Penyerahan</th>
                                      <th>No Order</th>
                                      <th>Lab</th>
                                      <th>Yantek</th>
                                      <th>Tahun</th>
                                      <th>Action</th>
                                    </tr>
                                  </tfoot>
                                </table>

                                <!-- Modal -->
                                <div class="modal fade modal-rotate-from-bottom" id="myModal" aria-hidden="true" aria-labelledby="exampleModalTitle" role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
                                  <div class="modal-dialog modal-simple" style="max-width: 950px">
                                    <form class="form-horizontal" id="frmpenyerahan" autocomplete="off">
                                    <div class="modal-content">
                                      <div class="modal-header">
                                        <button type="button" class="close tutup" data-dismiss="modal" aria-label="Close">
                                          <span aria-hidden="true">×</span>
                                        </button>
                                        <h4 class="modal-title">Tambah Data Penyerahan Alat</h4>
                                      </div>
                                      <div class="modal-body">
                                          <div class="form-group row form-material">
                                            <label class="col-md-4 form-control-label">Tgl Penyerahan</label>
                                            <div class="col-md-8">
                                              <input type="date" class="form-control" name="tgl_serah" id="tgl_serah" />
                                            </div>
                                          </div>
                                          <div class="form-group row form-material">
                                            <label class="col-md-4 form-control-label">No Order</label>
                                            <div class="col-md-8">
                                              <input type="hidden" class="form-control no_order" id="no_order" name="no_order" />
                                            </div>
                                          </div>
                                          <div class="form-group row form-material">
                                            <label class="col-md-4 form-control-label">Yang Menyerahkan (Lab)</label>
                                            <div class="col-md-8">
                                              <input type="hidden" class="form-control petugas_lab" onchange="get_detail_order(this.value)" name="petugas_lab" id="petugas_lab"/>
                                            </div>
                                          </div>
                                          <div class="form-group row form-material">
                                            <label class="col-md-4 form-control-label">Yang Menerima (Yantek)</label>
                                            <div class="col-md-8">
                                              <input type="hidden" class="form-control petugas_yantek" name="petugas_yantek" id="petugas_yantek"/>
                                            </div>
                                          </div>
                                          <div class="form-group row form-material">
                                            <label class="col-md-4 form-control-label">Catatan</label>
                                            <div class="col-md-8">
                                              <textarea name="catatan" id="catatan" class="form-control" rows="3" required="required"></textarea>
                                            </div>
                                          </div>
                                          <table class="table table-bordered table-hover dataTable table-striped w-full" id="tableorder">
                                            <thead>
                                              <tr>
                                                <th>#</th>
                                                <th>Nama Alat</th>
                                                <th>Nomor Seri</th>
                                                <th>Catatan</th>
                                              </tr>
                                            </thead>
                                            <tfoot>
                                              <tr>
                                                <th>#</th>
                                                <th>Nama Alat</th>
                                                <th>Nomor Seri</th>
                                                <th>Catatan</th>
                                              </tr>
                                            </tfoot>
                                            
                                          </table>
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



{!! HTML::script('js/ajax-penyerahan.js') !!}
@stop
