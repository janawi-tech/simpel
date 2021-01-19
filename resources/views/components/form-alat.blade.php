						<div class="modal-body">
                          <div class="alert alert-danger col-12">
                            <strong>Perhatian !</strong> Mohon cek kembali data yang anda input sebelum melanjutkan
                          </div>

<div class="row">
        <div class="col-lg-4">
        	<div class="form-group row form-material">
				<div class="col-12">
					<input type="text" class="form-control input-sm has-error" placeholder="Nomor Order" id="no_orders" name="no_orders" data-validate="required" readonly>
				</div>
			</div>
        	<div class="form-group row form-material">
				<div class="col-12">
					<input type="hidden" class="form-control alat" name="alat_id" data-validate="required">
				</div>
			</div>
			<div class="form-group row form-material">
				<div class="col-12">
					<input type="text" class="form-control input-sm has-error" placeholder="Harga Alat" id="harga" name="harga" data-validate="required">
				</div>
			</div>
			<div class="form-group row form-material">
				<div class="col-12">
					<input type="text" class="form-control input-sm has-error" placeholder="Merek" id="merek" name="merek" data-validate="required">
				</div>
			</div>
        </div>
        <div class="col-lg-4">
			<div class="form-group row form-material">
				<div class="col-12">
					<input type="text" class="form-control input-sm has-error" placeholder="Model/Tipe" id="pemilik" name="pemilik" data-validate="required">
				</div>
			</div>
			<div class="form-group row form-material">
				<div class="col-12">
					<input type="text" class="form-control input-sm has-error" id="no_seri" placeholder="Nomor Seri" name="no_seri" data-validate="required">
				</div>
			</div>
			<div class="form-group row form-material">
				<div class="col-12">
					<input type="number" class="form-control input-sm has-error" id="jumlah" placeholder="Jumlah Alat" name="jumlah" data-validate="required">
				</div>
			</div>
			<div class="form-group row form-material">
				<div class="col-12">
					<input type="text" class="form-control input-sm has-error" id="fungsi" name="fungsi" data-validate="required">
				</div>
			</div>
        </div>
        <div class="col-lg-4">
			<div class="form-group row form-material">
				<div class="col-12">
					<textarea class="form-control input-sm" name="kelengkapan" id="kelengkapan" rows="4">Aksesoris/Kelengkapan</textarea>
				</div>
			</div>
			<div class="form-group row form-material">
				<div class="col-12">
					<textarea class="form-control input-sm" name="ket" id="ket" rows="4">Keterangan</textarea>
				</div>
			</div>
			<div class="form-group row form-material">
				<div class="col-12">
					<button type="submit" class="btn btn-success"><i class="icon md-plus"></i> Tambah Alat </button>
				</div>
			</div>
        </div>
        <div class="col-lg-12">
        	<table class="table table-bordered table-hover dataTable table-striped w-full" id="tablecustomer">
	            <thead>
	              <tr>
	                <th width="4%">No</th>
	                <th>Alat</th>
	                <th>Merk</th>
	                <th>Model</th>
	                <th>No Seri</th>
	                <th>Jumlah</th>
	                <th>Harga</th>
	                <th>Fungsi</th>
	                <th>Aksesoris</th>
	                <th>Ket</th>
	                <th>Action</th>
	              </tr>
	            </thead>
	            <tfoot>
	              <tr>
	                <th width="4%">No</th>
	                <th>Alat</th>
	                <th>Merk</th>
	                <th>Model</th>
	                <th>No Seri</th>
	                <th>Jumlah</th>
	                <th>Harga</th>
	                <th>Fungsi</th>
	                <th>Aksesoris</th>
	                <th>Ket</th>
	                <th>Action</th>
	              </tr>
	            </tfoot>
	        </table>
        </div>
</div>
						</div>
                        <div class="modal-footer">
                          <button type="button" data-dismiss="modal" class="btn btn-round btn-primary btn-pill-right waves-effect waves-classic">Selesai <i class="icon md-check"></i></button>
                        </div>