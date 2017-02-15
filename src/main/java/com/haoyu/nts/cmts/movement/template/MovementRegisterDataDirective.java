package com.haoyu.nts.cmts.movement.template;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;

import com.github.miemiedev.mybatis.paginator.domain.PageBounds;
import com.haoyu.cmts.movement.entity.MovementRegister;
import com.haoyu.cmts.movement.service.IMovementRegisterCmtsService;
import com.haoyu.sip.core.freemarker.AbstractTemplateDirectiveModel;

import freemarker.core.Environment;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.TemplateDirectiveBody;
import freemarker.template.TemplateException;
import freemarker.template.TemplateModel;


@Component
public class MovementRegisterDataDirective extends AbstractTemplateDirectiveModel{

	@Resource
	private IMovementRegisterCmtsService movementRegisterService ;
	@Override
	public void execute(Environment env, Map params, TemplateModel[] loopVars, TemplateDirectiveBody body)
			throws TemplateException, IOException {
		PageBounds pageBounds = getPageBounds(params);
		Map<String,Object> paramerts = getSelectParam(params);
		
		if (paramerts.containsKey("movementId") && StringUtils.isNotEmpty(paramerts.get("movementId").toString().trim())) {
			List<MovementRegister> movementRegisters = movementRegisterService.list(paramerts, pageBounds);
			env.setVariable("movementRegisters", new DefaultObjectWrapper().wrap(movementRegisters));
		}
		body.render(env.getOut());
	}
	

}
