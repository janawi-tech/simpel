<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class SPK extends Model
{
    protected $primaryKey = 'id';
	public $incrementing = false;
	protected $table = 'lab_spk';

	// protected $casts = [
	//     'alat_id' => 'array', // Will convarted to (Array)
	// ];

    protected $fillable = ['id_order','no_order','petugas_id','unit_kerja','alat_id','tempat','ka_instalasi','tgl_spk','catatan'];
}
