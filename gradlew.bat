package etelligens.com.foodsafety.fragments.tempLogFrag;

import android.app.Activity;
import android.app.DownloadManager;
import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.widget.SwipeRefreshLayout;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.LinearLayout;
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

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import etelligens.com.foodsafety.R;
import etelligens.com.foodsafety.activities.ItemSelection;
import etelligens.com.foodsafety.activities.temp.TempLogHistoryByDateAct;
import etelligens.com.foodsafety.adapter.TempLogHistoryAdapter;
import etelligens.com.foodsafety.fragments.dbhome.AdminDashboardFrag;
import etelligens.com.foodsafety.model.Emp;
import etelligens.com.foodsafety.model.TempLogHistoryModal;
import etelligens.com.foodsafety.utils.BaseFragment;

import static etelligens.com.foodsafety.utils.EndPoint.ETE_BASE_URL;
import static etelligens.com.foodsafety.utils.EndPoint.ETE_DOWNLOAD_TEMP_LOG_HISTORY;
import static etelligens.com.foodsafety.utils.EndPoint.ETE_IMAGE_BASEURL;
import static etelligens.com.foodsafety.utils.EndPoint.ETE_TEMP_LOG_HISTORY;
import static etelligens.com.foodsafety.utils.Keyword.ETE_DATA;
import static etelligens.com.foodsafety.utils.Keyword.ETE_MSG;
import static etelligens.