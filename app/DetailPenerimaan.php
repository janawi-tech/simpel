<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class DetailPenerimaan extends Model
{
    protected $primaryKey = 'id';
	public $incrementing = false;
	protected $table = 'lab_detail_order';

    protected $fillable = [
            'id_order',
    		'no_order',
    		'alat_id',
    		'merek',
    		'model',
    		'seri',
    		'jumlah',
    		'fungsi',
    		'kelengkapan',
    		'keterangan'
    ];
}
