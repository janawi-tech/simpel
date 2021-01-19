<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
    protected $primaryKey = 'id';
	public $incrementing = false;
	protected $table = 'lab_customer';

    protected $fillable = ['id_order','pemilik','setatus','jenis','provinsi_id','kabupaten_id','alamat','telepon','cp','hp','no_order'];
}
