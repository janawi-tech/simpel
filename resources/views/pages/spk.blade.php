@extends('admin-template')
@section('content')
          
                <div class="row">
                    <div class="col-sm-12">
                        <div class="page-title-box">
                            <div class="btn-group pull-right">
                                <ol class="breadcrumb hide-phone p-0 m-0">
                                    <li class="breadcrumb-item"><a href="{{ route('admin.dashboard') }}">LPFK BJB</a></li>
                                    <li class="breadcrumb-item active">SPK</li>
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
                                <table class="table table-striped table-bordered" cellspacing="0" width="100%" id="tablespk">
                                  <thead>
                                    <tr>
                                      <th>No</th>
                                      <th>No Order</th>
                                      <th>Nama</th>
                                      <th>Ka Instalasi</th>
                                      <th>Tahun</th>
                                      <th>Action</th>
                                    </tr>
                                  </thead>
                                  <tfoot>
                                    <tr>
                                      <th>No</th>
                                      <th>No Order</th>
                                      <th>Nama</th>
                                      <th>Ka Instalasi</th>
                                      <th>Tahun</th>
                                      <th>Action</th>
                                    </tr>
                                  </tfoot>
                                </table>

                                <!-- Modal -->
                                  <div class="modal fade modal-rotate-from-bottom" id="myModal" aria-hidden="true" aria-labelledby="exampleModalTitle" role="dialog" tabindex="-1" data-backdrop="static" data-keyboard="false">
                                    <div class="modal-dialog modal-simple" style="max-width: 750px">
                                      <form class="form-horizontal" id="frmspk" autocomplete="off">
                                      <div class="modal-content">
                                        <div class="modal-header">
                                          <button type="button" class="close tutup" data-dismiss="modal" aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                          </button>
                                          <h4 class="modal-title">Tambah SPK</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Petugas</label>
                                              <div class="col-md-8">
                                                <input type="hidden" class="form-control petugas_id" name="petugas_id" />
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Unit Kerja</label>
                                              <div class="col-md-8">
                                                <input type="text" class="form-control" name="unit_kerja" id="unit_kerja" value="Laboratorium Kalibrasi LPFK Banjarbaru" />
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">No Order</label>
                                              <div class="col-md-8">
                                                <input type="hidden" class="form-control no_order" id="no_order" onchange="reset_alat(this.value)" name="no_order" />
                                              </div>
                                            </div>
                                            <div class="form-group row">
                                              <label class="col-md-4 form-control-label">Alat</label>
                                              <div class="col-md-8">
                                                <input type="text" class="form-control alat_id" name="alat_id[]" multiple/>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Tempat</label>
                                              <div class="col-md-8">
                                                <input type="hidden" class="form-control tempat" name="tempat" />
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Kepala Instalasi</label>
                                              <div class="col-md-8">
                                                <input type="hidden" class="form-control ka_instalasi" name="ka_instalasi" />
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Tgl SPK</label>
                                              <div class="col-md-8">
                                                <input type="date" class="form-control" name="tgl_spk" id="tgl_spk"/>
                                              </div>
                                            </div>
                                            <div class="form-group row form-material">
                                              <label class="col-md-4 form-control-label">Catatan</label>
                                              <div class="col-md-8">
                                                <textarea name="catatan" id="catatan" class="form-control" rows="3" required="required"></textarea>
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

{!! HTML::script('js/ajax-spk.js') !!}
@stop
