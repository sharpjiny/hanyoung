package com.bogoManager.controller.web;

import com.bogoManager.Constant;
import com.bogoManager.controller.DefaultController;
import com.bogoManager.mapper.ProcessFlowMapper;
import java.net.UnknownHostException;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping({"/production/flow/"})
public class ProcessFlowController
  extends DefaultController
{
  @Autowired
  ProcessFlowMapper flowMapper;
  String TILESForder = "production";
  
  @ModelAttribute("menuType")
  public String type() { return this.TILESForder; }
  
  @RequestMapping({"search"})
  public String list(Model model, @RequestParam HashMap<String, Object> paramMap, @RequestParam(required = false) String logMsg) throws UnknownHostException {
    String jspName = "search";
    model.addAttribute("list", this.flowMapper.selectProcessFlowList(paramMap));
    model.addAttribute("pageParam", paramMap);
    
    return String.valueOf(this.TILESForder) + "/flow/" + jspName + Constant.TILES;
  }
}
