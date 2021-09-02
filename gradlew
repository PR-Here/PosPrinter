package etelligens.com.foodsafety.fragments.productFrag;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.SharedElementCallback;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.text.Editable;
import android.text.TextUtils;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.android.volley.AuthFailureError;
import com.android.volley.DefaultRetryPolicy;
import com.android.volley.NoConnectionError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import net.gotev.uploadservice.MultipartUploadRequest;
import net.gotev.uploadservice.UploadNotificationConfig;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.File;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import etelligens.com.foodsafety.R;
import etelligens.com.foodsafety.activities.ItemSelection;
import etelligens.com.foodsafety.activities.MultipleItemSelection;
import etelligens.com.foodsafety.activities.dashboard.Dashboard;
import etelligens.com.foodsafety.activities.sidemenu.AddNewInventoryItemAct;
import etelligens.com.foodsafety.adapter.MasterProductAdapter;
import etelligens.com.foodsafety.adapter.MasterProductChildAdapter;
import etelligens.com.foodsafety.model.MasterProductChildM;
import etelligens.com.foodsafety.model.MasterProductParentM;
import etelligens.com.foodsafety.utils.BaseFragment;
import etelligens.com.foodsafety.utils.FilePath;

import static android.app.Activity.RESULT_OK;
import static etelligens.com.foodsafety.utils.EndPoint.ETE_BASE_URL;
import static etelligens.com.foodsafety.utils.EndPoint.ETE_DELTE_MULTI_PRODUCT;
import static etelligens.com.foodsafety.utils.EndPoint.ETE_GET_ALL_PRODUCT_DETAILS;
import static etelligens.com.foodsafety.utils.Keyword.MY_SOCKET_TIMEOUT;

public class MasterProductListFrag extends BaseFragment implements View.OnClickListener, SwipeRefreshLayout.OnRefreshListener {

    RecyclerView inventoryRecyclerview;
    MasterProductAdapter inventoryItemsA;
    SwipeRefreshLayout swipe;
    MasterProductChildAdapter masterProductChildAdapter;
    ArrayList<MasterProductParentM> inventoryChildItemMS = new ArrayList<>();
    ImageView addbtn, importImg;
    TextView cancelbtn, tvChoosePartner, tvChooseOutlet, text, dashboardtxt;
    EditText searchtext;
    RelativeLayout rleditlayout, rlchecklayout, rldeletelayout;
    LinearLayout llsearchlayout;
    Gson gson = new Gson();
    String idValue, getproducts,productCode,selectside,catIdd, catIDs, storageID, searchText = "", sName, itemName, allOutletLenth, keyButton = "empty", pID = "empty", partnerName, str, catName, catID;
    ArrayList<String> dataArray = new ArrayList<>();
    File selected_file;
    private Uri filePath;
    public static final String UPLOAD_URL = ETE_BASE_URL + "product/ImportExcelProduct";
    int count = 0;
    ArrayList<String> oID;
    ArrayList<String> outletName;
    ArrayList<String> idArray = new ArrayList<>();
    ArrayList<String> nameArray;
    SharedPreferences.Editor spPref;
    SharedPreferences userData, outletIdsData;


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    View view;

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        view = inflater.inflate(R.layout.fragment_inventory_list, container, false);

        Bundle extras = getArguments();
        if (extras != null) {
            oID = extras.getStringArrayList("oID");
            pID = extras.getString("pID");
            partnerName = extras.getString("pName");
            outletName = extras.getStringArrayList("oName");
            allOutletLenth = extras.getString("outletSelectID");
            getproducts = extras.getString("layout");
            catIDs = extras.getString("catID");
            storageID = extras.getString("storageAreaID");
            productCode=extras.getString("product_code");
            sName = extras.getString("sName");
            selectside=extras.getString("selection_id");

        }


        if(selectside!=null){
            outletIdsData = getActivity().getSharedPreferences("OutletData", Context.MODE_PRIVATE);
            spPref = outletIdsData.edit();
            spPref.clear();
            spPref.commit();
        }

        getSavedData();
        getselectedLangua