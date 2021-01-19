<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class ComponentController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:admin');
    }

    public function showFormOrder()
    {
    	return view('components.form-order');
    }

    public function showFormAlat()
    {
    	return view('components.form-alat');
    }

    public function showFormPetugas()
    {
        return view('components.form-petugas');
    }
}
