<?php

namespace App\Http\Controllers;

use App\Customer;
use Illuminate\Http\Request;
use Yajra\DataTables\DataTables;
use Redirect;
use Response;
use DB;

class CustomerController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:admin');
    }
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('pages.customer');
    }

    public function getPosts()
    {
        DB::statement(DB::raw('set @rownum=0'));
        $customer = Customer::select([
            DB::raw('@rownum  := @rownum  + 1 AS rownum'),
            'id',
            'name',
            'address']);
        // $customer = Customer::all();

        return DataTables::of($customer)
                ->addColumn('check', function ($customer) {
                    return '
                                <div class="checkbox-custom checkbox-primary">
                                  <input class="customer_checkbox" type="checkbox" name="customer_checkbox[]" value="'.$customer->id.'">
                                  <label>'.$customer->rownum.'</label>
                                </div>';
                })
                ->addColumn('action', function ($customer) {
                    return '
                            <button type="button" class="btn btn-sm btn-icon btn-success waves-effect waves-classic open-modal" value="'.$customer->id.'"><i class="icon md-edit" aria-hidden="true"></i>
                            </button>
                            <button type="button" class="btn btn-sm btn-icon btn-danger waves-effect waves-classic btn-delete delete-task" value="'.$customer->id.'"><i class="icon md-delete" aria-hidden="true"></i>
                            </button>';
                })
                ->rawColumns(['action','check'])
                ->make(true);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $customer = Customer::create($request->all());
        return Response::json($customer);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $customer = Customer::find($id);
        return Response::json([
            'id'=>$customer->id,
            'name'=>$customer->name,
            'address'=>$customer->address
        ]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $customer = Customer::find($id);
        $customer->name = $request->name;
        $customer->address = $request->address;
        $customer->save();

        return Response::json($customer);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $customer = Customer::destroy($id);
        return Response::json($customer);
    }

    public function massremove(Request $request)
    {
        $customer_id_array = $request->input('id');
        $customer = Customer::whereIn('id',$customer_id_array);
        if ($customer->delete()) {
            return Response::json($customer);
        }
    }
}
